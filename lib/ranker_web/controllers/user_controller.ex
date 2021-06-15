defmodule RankerWeb.UserController do
  use RankerWeb, :controller

  alias Ranker.Authentication
  alias Ranker.Authentication.User

  plug RankerWeb.Plugs.RequireLogin when action in [:index, :show, :update, :delete]
  plug :require_owner_of_account when action in [:edit, :update, :delete]

  action_fallback RankerWeb.FallbackController

  def index(conn, _params) do
    users = Authentication.list_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    try do
      user_id = String.to_integer(id)

      user = cond do
        user_id == conn.assigns[:user_id] ->
          user = Authentication.get_user_with_pool!(id)
        true ->
          user = Authentication.get_user!(id)
        end
      render(conn, "show.json", user: user)
    rescue
      _e in ArgumentError ->
        conn
        |> Plug.Conn.put_status(403)
        |> put_view(RankerWeb.ErrorView)
        |> render("403.json", message: "Incorrect user ID.", details: "User ID must be numerical.")
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Authentication.get_user!(id)

    with {:ok, %User{} = user} <- Authentication.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Authentication.get_user!(id)

    with {:ok, %User{}} <- Authentication.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def require_owner_of_account(conn, _params) do
    %{params: %{"id" => user_id}} = conn
    current_user_id = Plug.Conn.get_session(:user_id)
    if user_id == current_user_id do
      conn
    else
      conn
      |> Plug.Conn.put_status(:forbidden)
      |> Plug.Conn.halt()
    end
  end
end

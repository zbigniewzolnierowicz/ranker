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
          Authentication.get_user_with_everything!(id)
        true ->
          Authentication.get_user!(id)
        end
      render(conn, "show.json", user: user, private: user_id != conn.assigns[:user_id])
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

  defp convert_string_to_integer(possible_integer) do
    cond do
      is_bitstring(possible_integer) -> String.to_integer(possible_integer)
      is_integer(possible_integer) -> possible_integer
    end
  end

  def send_money(conn, %{"id" => id, "send_to" => send_to_id, "amount" => amount}) do
    try do
      id = convert_string_to_integer(id)
      send_to_id = convert_string_to_integer(send_to_id)
      amount = convert_string_to_integer(amount)
      if (id == send_to_id) do
        conn
        |> put_status(403)
        |> put_view(RankerWeb.ErrorView)
        |> render("403.json", details: "You cannot send points to yourself.")
      end
      user = Authentication.get_user_with_pool!(id)
      recipient_user = Authentication.get_user!(send_to_id)
      %User{pool: %Ranker.PointTrading.Pool{points: points}} = user
      cond do
        points < amount ->
          conn
          |> put_status(409)
          |> put_view(RankerWeb.ErrorView)
          |> render("409.json", message: "Not enough points.", details: "You do not have enough points to send to this user.")
        true ->
          case Authentication.send_points_to_user(user, recipient_user, amount) do
            {:ok, %{pool: pool, user: _recipient}} ->
              conn
              |> put_status(202)
              |> render("show.json", user: %User{user | pool: pool}, private: false)
            true ->
              conn
              |> put_status(500)
              |> put_view(RankerWeb.ErrorView)
              |> render("500.json", message: "An error occured while writing the changes to a database")
          end
      end
    rescue
      _e in ArgumentError ->
        conn
        |> Plug.Conn.put_status(403)
        |> put_view(RankerWeb.ErrorView)
        |> render("403.json", message: "Incorrect user ID or amount of points.", details: "User ID, recipient ID and amount of points send must all be numerical.")
    end
  end

  def require_owner_of_account(conn, _params) do
    %{params: %{"id" => user_id}} = conn
    current_user_id = conn.assigns[:user_id]
    if user_id == current_user_id do
      conn
    else
      conn
      |> put_status(401)
      |> put_view(RankerWeb.ErrorView)
      |> render("401.json")
      |> halt()
    end
  end
end

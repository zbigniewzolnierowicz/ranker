defmodule RankerWeb.AuthController do
  use RankerWeb, :controller
  plug Ueberauth

  alias Ranker.Authentication

  action_fallback RankerWeb.FallbackController

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    %Ueberauth.Auth.Info{email: email, name: name} = auth.info
    params = %{email: email, name: name, provider: provider, token: auth.credentials.token}
    case Authentication.upsert_user(params) do
      {:ok, %{user: %Ranker.Authentication.User{} = user}} ->
        good_login(conn, user)
      true ->
        bad_login(conn)
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _failure}} = conn, _params), do: bad_login(conn)

  defp bad_login(conn) do
    conn
    |> configure_session(drop: true)
    |> delete_resp_cookie("user_id")
    |> redirect(to: RankerWeb.Router.Helpers.page_path(conn, :index, path: "fail"))
  end

  defp good_login(conn, %Ranker.Authentication.User{id: user_id}) do
    conn
    |> put_session(:user_id, user_id)
    |> put_resp_cookie("user_id", Integer.to_string(user_id), http_only: false)
    |> Plug.Conn.assign(:user_id, user_id)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> delete_resp_cookie("user_id")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end

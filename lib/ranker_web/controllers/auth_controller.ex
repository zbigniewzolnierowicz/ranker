defmodule RankerWeb.AuthController do
  use RankerWeb, :controller
  plug Ueberauth

  alias Ranker.Authentication

  action_fallback RankerWeb.FallbackController

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    %Ueberauth.Auth.Info{email: email, name: name} = auth.info
    params = %{email: email, name: name, provider: provider, token: auth.credentials.token}
    case Authentication.upsert_user(params) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> Plug.Conn.put_resp_cookie("user_id", Integer.to_string(user.id), http_only: false)
        |> redirect(to: Routes.page_path(conn, :index))
      true ->
        bad_login(conn)
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _failure}} = conn, _params), do: bad_login(conn)

  defp bad_login(conn) do
    conn
    |> delete_resp_cookie("user_id")
    |> redirect(to: RankerWeb.Router.Helpers.page_path(conn, :index, path: "fail"))
  end

  def logout(conn, _params) do
    IO.puts(Plug.Conn.get_session(conn, :user_id))
    conn
    |> configure_session(drop: true)
    |> delete_resp_cookie("user_id")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end

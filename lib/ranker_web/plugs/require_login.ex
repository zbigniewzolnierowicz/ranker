defmodule RankerWeb.Plugs.RequireLogin do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do
    conn = fetch_session(conn)
    if get_session(conn, :user_id) do
      conn
    else
      conn
      |> put_status(403)
      |> put_view(RankerWeb.ErrorView)
      |> render("403.json")
      |> halt()
    end
  end
end

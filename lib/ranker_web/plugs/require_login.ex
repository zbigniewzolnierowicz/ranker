defmodule RankerWeb.Plugs.RequireLogin do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
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

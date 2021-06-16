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
      |> put_status(401)
      |> put_view(RankerWeb.ErrorView)
      |> render("401.json")
      |> halt()
    end
  end
end

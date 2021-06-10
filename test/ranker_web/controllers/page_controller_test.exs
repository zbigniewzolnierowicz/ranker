defmodule RankerWeb.PageControllerTest do
  use RankerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<div id=\"app\"></div>"
  end

  test "GET /<random string>", %{conn: conn} do
    conn = get(conn, "/foobar")
    assert html_response(conn, 200) =~ "<div id=\"app\"></div>"
  end
end

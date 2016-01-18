defmodule Donegood.PageControllerTest do
  use Donegood.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Donegood!"
  end
end

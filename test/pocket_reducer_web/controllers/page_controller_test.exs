defmodule PocketReducerWeb.PageControllerTest do
  use PocketReducerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "PocketReducer"
  end
end

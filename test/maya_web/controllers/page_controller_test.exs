defmodule MayaWeb.PageControllerTest do
  use MayaWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Images"
  end
end

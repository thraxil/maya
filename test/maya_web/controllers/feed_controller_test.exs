defmodule MayaWeb.FeedControllerTest do
  use MayaWeb.ConnCase

  test "GET /feeds/main/", %{conn: conn} do
    conn = get(conn, "/feeds/main/")
    assert response(conn, 200) =~ "Myopica"
  end
end

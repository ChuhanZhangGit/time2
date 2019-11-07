defmodule Time2Web.DaysheetControllerTest do
  use Time2Web.ConnCase

  alias Time2.Daysheets
  alias Time2.Daysheets.Daysheet

  @create_attrs %{
    approved: true,
    date: ~D[2010-04-17]
  }
  @update_attrs %{
    approved: false,
    date: ~D[2011-05-18]
  }
  @invalid_attrs %{approved: nil, date: nil}

  def fixture(:daysheet) do
    {:ok, daysheet} = Daysheets.create_daysheet(@create_attrs)
    daysheet
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all daysheets", %{conn: conn} do
      conn = get(conn, Routes.daysheet_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create daysheet" do
    test "renders daysheet when data is valid", %{conn: conn} do
      conn = post(conn, Routes.daysheet_path(conn, :create), daysheet: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.daysheet_path(conn, :show, id))

      assert %{
               "id" => id,
               "approved" => true,
               "date" => "2010-04-17"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.daysheet_path(conn, :create), daysheet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update daysheet" do
    setup [:create_daysheet]

    test "renders daysheet when data is valid", %{conn: conn, daysheet: %Daysheet{id: id} = daysheet} do
      conn = put(conn, Routes.daysheet_path(conn, :update, daysheet), daysheet: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.daysheet_path(conn, :show, id))

      assert %{
               "id" => id,
               "approved" => false,
               "date" => "2011-05-18"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, daysheet: daysheet} do
      conn = put(conn, Routes.daysheet_path(conn, :update, daysheet), daysheet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete daysheet" do
    setup [:create_daysheet]

    test "deletes chosen daysheet", %{conn: conn, daysheet: daysheet} do
      conn = delete(conn, Routes.daysheet_path(conn, :delete, daysheet))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.daysheet_path(conn, :show, daysheet))
      end
    end
  end

  defp create_daysheet(_) do
    daysheet = fixture(:daysheet)
    {:ok, daysheet: daysheet}
  end
end

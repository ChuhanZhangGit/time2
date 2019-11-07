defmodule Time2Web.DaysheetController do
  use Time2Web, :controller

  alias Time2.Daysheets
  alias Time2.Daysheets.Daysheet

  action_fallback Time2Web.FallbackController

  def index(conn, _params) do
    daysheets = Daysheets.list_daysheets()
    render(conn, "index.json", daysheets: daysheets)
  end

  def create(conn, %{"daysheet" => daysheet_params}) do
    with {:ok, %Daysheet{} = daysheet} <- Daysheets.create_daysheet(daysheet_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.daysheet_path(conn, :show, daysheet))
      |> render("show.json", daysheet: daysheet)
    end
  end

  def show(conn, %{"id" => id}) do
    daysheet = Daysheets.get_daysheet!(id)
    render(conn, "show.json", daysheet: daysheet)
  end

  def update(conn, %{"id" => id, "daysheet" => daysheet_params}) do
    daysheet = Daysheets.get_daysheet!(id)

    with {:ok, %Daysheet{} = daysheet} <- Daysheets.update_daysheet(daysheet, daysheet_params) do
      render(conn, "show.json", daysheet: daysheet)
    end
  end

  def delete(conn, %{"id" => id}) do
    daysheet = Daysheets.get_daysheet!(id)

    with {:ok, %Daysheet{}} <- Daysheets.delete_daysheet(daysheet) do
      send_resp(conn, :no_content, "")
    end
  end
end

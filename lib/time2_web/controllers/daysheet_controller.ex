defmodule Time2Web.DaysheetController do
  use Time2Web, :controller

  alias Time2.Daysheets
  alias Time2.Daysheets.Daysheet

  action_fallback Time2Web.FallbackController

  def index(conn, _params) do
    daysheets = Daysheets.list_daysheets()
    render(conn, "index.json", daysheets: daysheets)
  end


    def update_sheet_param(daysheet_params, current_user) do
    daysheet_params
    |> Map.put("manager_id", current_user.manager_id)
    |> Map.put("worker_id", current_user.id) 
  end

  def filter_param(daysheet_params, current_user) do 
    if (current_user.group != "manager") do 
      daysheet_params = Map.delete(daysheet_params, "approved")
      daysheet_params
    else
      daysheet_params
    end
  end

  def create(conn, %{"daysheet" => daysheet_params}) do
    # current user may be undefined
    current_user =  conn.assigns[:current_user]
    daysheet_params = daysheet_params
    |> update_sheet_param(current_user)
    |> filter_param(current_user)

    case Daysheets.create_daysheet(daysheet_params) do
      {:ok, daysheet} ->
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.daysheet_path(conn, :show, daysheet))
      |> render("show.json", daysheet: daysheet)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def create(conn, %{"daysheet" => daysheet_params}) do

  #   # current_user may be undefined
  #   current_user =  conn.assigns[:current_user]
  #   daysheet_params = daysheet_params
  #   |> update_sheet_param(current_user)
  #   |> filter_param(current_user)

  #   with {:ok, %Daysheet{} = daysheet} <- Daysheets.create_daysheet(daysheet_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.daysheet_path(conn, :show, daysheet))
  #     |> render("show.json", daysheet: daysheet)
  #   end
  # end

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

defmodule Time2Web.DaysheetView do
  use Time2Web, :view
  alias Time2Web.DaysheetView

  def render("index.json", %{daysheets: daysheets}) do
    %{data: render_many(daysheets, DaysheetView, "daysheet.json")}
  end

  def render("show.json", %{daysheet: daysheet}) do
    %{data: render_one(daysheet, DaysheetView, "daysheet.json")}
  end

  def render("daysheet.json", %{daysheet: daysheet}) do
    %{id: daysheet.id,
      date: daysheet.date,
      approved: daysheet.approved}
  end
end

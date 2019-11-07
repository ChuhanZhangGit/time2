defmodule Time2.Daysheets.Daysheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daysheets" do
    field :approved, :boolean, default: false
    field :date, :date
    field :manager_id, :id
    field :worker_id, :id

    timestamps()
  end

  @doc false
  def changeset(daysheet, attrs) do
    daysheet
    |> cast(attrs, [:date, :approved])
    |> validate_required([:date, :approved])
  end
end

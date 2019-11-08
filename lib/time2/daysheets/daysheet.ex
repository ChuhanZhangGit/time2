defmodule Time2.Daysheets.Daysheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daysheets" do
    field :approved, :boolean, default: false
    field :date, :date
    field :manager_id, :id
    field :worker_id, :id
    has_many :tasks, Time2.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(daysheet, attrs) do
    IO.puts("asasdfasd")
    IO.inspect(attrs)
    if validate_hour(attrs) do 
      daysheet
      |> cast(attrs, [:date, :approved, :manager_id, :worker_id])
      |> cast_assoc(:tasks)
      |> validate_required([:date, :approved, :manager_id, :worker_id])
    else
      daysheet
      |> cast(attrs, [:date, :approved, :manager_id, :worker_id])
      |> validate_required([:date, :approved, :manager_id, :worker_id])
    end
  end

  def validate_hour(attrs) do 
    if (attrs["tasks"] != nil) do 
      total_hrs = attrs["tasks"]
      |> Map.values
      |> Enum.filter(fn e -> e["hours"] != "" end )
      |> Enum.map(fn e -> 
        IO.inspect(e)
        {hr, _} = Float.parse(e["hours"]); 
        hr end )
      |> Enum.reduce(fn x, acc -> x + acc end )
      total_hrs <= 8
    else
      false
    end
  end
end
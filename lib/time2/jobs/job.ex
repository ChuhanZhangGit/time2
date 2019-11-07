defmodule Time2.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :budget, :integer
    field :description, :string
    field :jobcode, :string
    field :name, :string
    field :manager_id, :id

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:jobcode, :budget, :name, :description])
    |> validate_required([:jobcode, :budget, :name, :description])
  end
end

defmodule Time2.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :hours, :float
    field :job_code, :string
    field :note, :string
    field :daysheet_id, :id
    field :job_id, :id
    field :worker_id, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:job_code, :hours, :note])
    |> validate_required([:job_code, :hours, :note])
  end
end

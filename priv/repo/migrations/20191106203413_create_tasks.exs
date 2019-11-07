defmodule Time2.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :job_code, :string
      add :hours, :float
      add :note, :string
      add :daysheet_id, references(:daysheets, on_delete: :nothing)
      add :job_id, references(:jobs, on_delete: :nothing)
      add :worker_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:daysheet_id])
    create index(:tasks, [:job_id])
    create index(:tasks, [:worker_id])
  end
end

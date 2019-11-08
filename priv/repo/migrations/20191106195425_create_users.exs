defmodule Time2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :group, :string
      add :email, :string
      add :name, :string
      add :manager_id, references(:users, on_delete: :nothing), null: true 
      add :password_hash, :string, null: false
      
      timestamps()
    end

  end
end

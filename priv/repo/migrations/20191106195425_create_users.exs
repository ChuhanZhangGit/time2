defmodule Time2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :group, :string
      add :email, :string
      add :name, :string
      add :manager, :string
      
      add :password_hash, :string, null: false


      timestamps()
    end

  end
end

defmodule Time2.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :group, :string
    field :manager, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:group, :email, :name, :manager])
    |> validate_required([:group, :email, :name, :manager])
  end
end

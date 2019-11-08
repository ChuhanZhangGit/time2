defmodule Time2.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :group, :string
    field :manager_id, :id
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  # Source Nate Tuck http://khoury.neu.edu/~ntuck/courses/2019/09/cs5610/notes/15-passwords/notes.html
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:group, :email, :name, :manager_id, :password, :password_confirmation])
    |> validate_confirmation(:password)
    # change back
    |> validate_length(:password, min: 1) # too short
    |> hash_password()
    |> validate_required([:email, :name, :password_hash])
  end

  def hash_password(cset) do
    pw = get_change(cset, :password)
    if pw do
      change(cset, Argon2.add_hash(pw))
    else
      cset
    end
  end
end

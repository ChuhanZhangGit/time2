defmodule Time2.Daysheets do
  @moduledoc """
  The Daysheets context.
  """

  import Ecto.Query, warn: false
  alias Time2.Repo

  alias Time2.Daysheets.Daysheet

  @doc """
  Returns the list of daysheets.

  ## Examples

      iex> list_daysheets()
      [%Daysheet{}, ...]

  """
  def list_daysheets do
    Repo.all(Daysheet)
  end

  @doc """
  Gets a single daysheet.

  Raises `Ecto.NoResultsError` if the Daysheet does not exist.

  ## Examples

      iex> get_daysheet!(123)
      %Daysheet{}

      iex> get_daysheet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daysheet!(id), do: Repo.get!(Daysheet, id)

  @doc """
  Creates a daysheet.

  ## Examples

      iex> create_daysheet(%{field: value})
      {:ok, %Daysheet{}}

      iex> create_daysheet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daysheet(attrs \\ %{}) do
    %Daysheet{}
    |> Daysheet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daysheet.

  ## Examples

      iex> update_daysheet(daysheet, %{field: new_value})
      {:ok, %Daysheet{}}

      iex> update_daysheet(daysheet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daysheet(%Daysheet{} = daysheet, attrs) do
    daysheet
    |> Daysheet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Daysheet.

  ## Examples

      iex> delete_daysheet(daysheet)
      {:ok, %Daysheet{}}

      iex> delete_daysheet(daysheet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daysheet(%Daysheet{} = daysheet) do
    Repo.delete(daysheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daysheet changes.

  ## Examples

      iex> change_daysheet(daysheet)
      %Ecto.Changeset{source: %Daysheet{}}

  """
  def change_daysheet(%Daysheet{} = daysheet) do
    Daysheet.changeset(daysheet, %{})
  end
end

defmodule Time2.DaysheetsTest do
  use Time2.DataCase

  alias Time2.Daysheets

  describe "daysheets" do
    alias Time2.Daysheets.Daysheet

    @valid_attrs %{approved: true, date: ~D[2010-04-17]}
    @update_attrs %{approved: false, date: ~D[2011-05-18]}
    @invalid_attrs %{approved: nil, date: nil}

    def daysheet_fixture(attrs \\ %{}) do
      {:ok, daysheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Daysheets.create_daysheet()

      daysheet
    end

    test "list_daysheets/0 returns all daysheets" do
      daysheet = daysheet_fixture()
      assert Daysheets.list_daysheets() == [daysheet]
    end

    test "get_daysheet!/1 returns the daysheet with given id" do
      daysheet = daysheet_fixture()
      assert Daysheets.get_daysheet!(daysheet.id) == daysheet
    end

    test "create_daysheet/1 with valid data creates a daysheet" do
      assert {:ok, %Daysheet{} = daysheet} = Daysheets.create_daysheet(@valid_attrs)
      assert daysheet.approved == true
      assert daysheet.date == ~D[2010-04-17]
    end

    test "create_daysheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Daysheets.create_daysheet(@invalid_attrs)
    end

    test "update_daysheet/2 with valid data updates the daysheet" do
      daysheet = daysheet_fixture()
      assert {:ok, %Daysheet{} = daysheet} = Daysheets.update_daysheet(daysheet, @update_attrs)
      assert daysheet.approved == false
      assert daysheet.date == ~D[2011-05-18]
    end

    test "update_daysheet/2 with invalid data returns error changeset" do
      daysheet = daysheet_fixture()
      assert {:error, %Ecto.Changeset{}} = Daysheets.update_daysheet(daysheet, @invalid_attrs)
      assert daysheet == Daysheets.get_daysheet!(daysheet.id)
    end

    test "delete_daysheet/1 deletes the daysheet" do
      daysheet = daysheet_fixture()
      assert {:ok, %Daysheet{}} = Daysheets.delete_daysheet(daysheet)
      assert_raise Ecto.NoResultsError, fn -> Daysheets.get_daysheet!(daysheet.id) end
    end

    test "change_daysheet/1 returns a daysheet changeset" do
      daysheet = daysheet_fixture()
      assert %Ecto.Changeset{} = Daysheets.change_daysheet(daysheet)
    end
  end
end

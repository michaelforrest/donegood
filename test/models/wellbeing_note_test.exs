defmodule Donegood.WellbeingNoteTest do
  use Donegood.ModelCase

  alias Donegood.WellbeingNote

  @valid_attrs %{field: "some content", text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WellbeingNote.changeset(%WellbeingNote{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WellbeingNote.changeset(%WellbeingNote{}, @invalid_attrs)
    refute changeset.valid?
  end
end

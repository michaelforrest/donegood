defmodule Donegood.WellbeingTest do
  use Donegood.ModelCase

  alias Donegood.Wellbeing

  @valid_attrs %{appreciated: 42, well_liked: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Wellbeing.changeset(%Wellbeing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Wellbeing.changeset(%Wellbeing{}, @invalid_attrs)
    refute changeset.valid?
  end
end

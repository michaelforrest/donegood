defmodule Donegood.WellbeingTest do
  use Donegood.ModelCase

  alias Donegood.Wellbeing
  @emotion_attrs ~w{appreciated well_liked confident loved in_control respected satisfied healthy successful happy lonely exploited taken_for_granted afraid stressed helpless frustrated angry sick sad}
  @valid_attrs Enum.map(@emotion_attrs, fn item, do: {item: 5} end)
  # user_id notes
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

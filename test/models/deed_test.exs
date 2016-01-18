defmodule Donegood.DeedTest do
  use Donegood.ModelCase

  alias Donegood.Deed

  @valid_attrs %{body: "some content", duration: :moment, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Deed.changeset(%Deed{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Deed.changeset(%Deed{}, @invalid_attrs)
    refute changeset.valid?
  end
end

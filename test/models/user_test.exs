defmodule Donegood.UserTest do
  use Donegood.ModelCase

  alias Donegood.User

  @valid_attrs %{bio: "some content", email: "some content", name: "some content", number_of_pets: 42}
  # @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end
  # until we figure out what our unique user id key will be
  # test "changeset with invalid attributes" do
  #   changeset = User.changeset(%User{}, @invalid_attrs)
  #   refute changeset.valid?
  # end
end

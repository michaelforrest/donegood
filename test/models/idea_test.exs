defmodule Donegood.IdeaTest do
  use Donegood.ModelCase

  alias Donegood.Idea

  @valid_attrs %{body: "some content", recipient_name: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Idea.changeset(%Idea{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Idea.changeset(%Idea{}, @invalid_attrs)
    refute changeset.valid?
  end
end

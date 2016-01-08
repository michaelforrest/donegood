defmodule Donegood.User do
  use Donegood.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :bio, :string
    field :number_of_pets, :integer

    has_many :deeds, Donegood.Deed
    timestamps
  end

  @required_fields ~w(name email bio)
  @optional_fields ~w(number_of_pets)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

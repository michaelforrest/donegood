defmodule Donegood.User do
  use Donegood.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :bio, :string
    field :facebook_id, :string
    field :facebook_token, :string

    field :google_id, :string
    field :google_token, :string

    field :twitter_id, :string

    has_many :deeds, Donegood.Deed
    has_many :wellbeings, Donegood.Wellbeing
    timestamps
  end

  @required_fields ~w() # this isn't good...
  @optional_fields ~w(name email bio facebook_id twitter_id facebook_token google_id google_token)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def is_new(user) do
    user.deeds.count == 0
  end
end

defmodule Donegood.Deed do
  use Donegood.Web, :model

  schema "deeds" do
    field :title, :string
    field :body, :string
    field :duration, :integer
    belongs_to :user, Donegood.User

    timestamps
  end

  @required_fields ~w(title body duration user_id)
  @optional_fields ~w()

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

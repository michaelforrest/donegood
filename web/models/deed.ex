defmodule Donegood.Deed do
  use Donegood.Web, :model

  schema "deeds" do
    field :title, :string # usually only this is seen really
    field :when, Ecto.Date
    field :body, :string # in "Express your gratitude" field probably
    field :duration, DurationEnum
    field :privacy, PrivacyEnum
    field :url, :string
    field :location, Geo.Point
    field :is_thanks, :boolean

    field :recipient_name, :string # if not another Donegood user
    field :relationship, :string # relationship with recipient

    belongs_to :user, Donegood.User
    belongs_to :recipient, Donegood.User
    belongs_to :created_by_user, Donegood.User

    timestamps
  end

  @required_fields ~w(title duration user_id privacy created_by_user_id when)
  @optional_fields ~w(duration body recipient_id url location is_thanks recipient_name relationship )

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

defmodule Donegood.Wellbeing do
  use Donegood.Web, :model

  schema "wellbeings" do
    field :appreciated, :integer
    field :well_liked, :integer
    field :confident, :integer
    field :loved, :integer
    field :in_control, :integer
    field :respected, :integer
    field :satisfied, :integer
    field :healthy, :integer
    field :successful, :integer
    field :happy, :integer

    field :lonely, :integer
    field :exploited, :integer
    field :taken_for_granted, :integer
    field :afraid, :integer
    field :stressed, :integer
    field :helpless, :integer
    field :angry, :integer
    field :sick, :integer
    field :sad, :integer
    
    belongs_to :user, Donegood.User

    timestamps
  end

  @required_fields ~w(appreciated well_liked)
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

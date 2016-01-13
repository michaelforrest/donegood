defmodule Donegood.WellbeingNote do
  use Donegood.Web, :model

  schema "wellbeing_notes" do
    field :text, :string
    field :field, :string
    belongs_to :wellbeing, Donegood.Wellbeing

    timestamps
  end

  @required_fields ~w(text field)
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

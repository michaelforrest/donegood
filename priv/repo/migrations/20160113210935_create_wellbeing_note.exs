defmodule Donegood.Repo.Migrations.CreateWellbeingNote do
  use Ecto.Migration

  def change do
    create table(:wellbeing_notes) do
      add :text, :text
      add :field, :text
      add :wellbeing_id, references(:wellbeings, on_delete: :nothing)

      timestamps
    end
    create index(:wellbeing_notes, [:wellbeing_id])

  end
end

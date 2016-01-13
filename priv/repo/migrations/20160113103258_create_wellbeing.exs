defmodule Donegood.Repo.Migrations.CreateWellbeing do
  use Ecto.Migration

  def change do
    create table(:wellbeings) do
      add :appreciated, :integer
      add :well_liked, :integer
      add :confident, :integer
      add :loved, :integer
      add :in_control, :integer
      add :respected, :integer
      add :satisfied, :integer
      add :healthy, :integer
      add :successful, :integer
      add :happy, :integer

      add :lonely, :integer
      add :exploited, :integer
      add :taken_for_granted, :integer
      add :afraid, :integer
      add :stressed, :integer
      add :frustrated, :integer
      add :helpless, :integer
      add :angry, :integer
      add :sick, :integer
      add :sad, :integer

      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:wellbeings, [:user_id])

  end
end

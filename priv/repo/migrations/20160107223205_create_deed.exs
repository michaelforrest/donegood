defmodule Donegood.Repo.Migrations.CreateDeed do
  use Ecto.Migration

  def change do
    create table(:deeds) do
      add :title, :string
      add :body, :string
      add :duration, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:deeds, [:user_id])

  end
end

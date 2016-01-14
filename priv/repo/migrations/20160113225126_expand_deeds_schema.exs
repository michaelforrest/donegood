defmodule Donegood.Repo.Migrations.ExpandDeedsSchema do
  use Ecto.Migration

  def change do
    alter table(:deeds) do
      add :url, :text
      add :when, :datetime
      add :privacy, :integer
      add :location, :geometry
      add :recipient_id, references(:users, on_delete: :nothing)
      add :created_by_user_id, references(:users, on_delete: :nothing)
      add :is_thanks, :boolean
    end
  end
end

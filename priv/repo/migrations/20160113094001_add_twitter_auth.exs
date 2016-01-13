defmodule Donegood.Repo.Migrations.AddTwitterAuth do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :twitter_id, :text
    end
  end
end

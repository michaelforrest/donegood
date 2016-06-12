defmodule Donegood.Repo.Migrations.AddRelationshipStuffToDeed do
  use Ecto.Migration

  def change do
    alter table(:deeds) do
      add :relationship, :string
      add :recipient_name, :string
    end
  end
end

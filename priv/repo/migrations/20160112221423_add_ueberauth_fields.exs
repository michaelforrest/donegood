defmodule Donegood.Repo.Migrations.AddUeberauthFields do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :facebook_id, :text
    end
  end
end

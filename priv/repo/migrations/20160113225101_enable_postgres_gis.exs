defmodule Donegood.Repo.Migrations.EnablePostgresGis do
  use Ecto.Migration

  # because https://github.com/bryanjos/geo
  def up do
     execute "CREATE EXTENSION IF NOT EXISTS postgis"
  end
  def down do
    execute "DROP EXTENSION IF EXISTS postgis"
  end
end

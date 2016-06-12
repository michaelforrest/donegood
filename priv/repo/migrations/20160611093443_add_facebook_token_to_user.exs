defmodule Donegood.Repo.Migrations.AddFacebookTokenToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :facebook_token, :string 
    end
  end
end

defmodule Donegood.Repo.Migrations.CreateIdea do
  use Ecto.Migration

  def change do
    create table(:ideas) do
      add :title, :string
      add :recipient_name, :string
      add :body, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end

  end
end

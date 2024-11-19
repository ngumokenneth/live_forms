defmodule Forms.Repo.Migrations.AddPasswordToUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password, :string, null: true
    end
  end
end

defmodule Invoices.Repo.Migrations.CreateUsersTable do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:email, :string, null: false)
      add(:password_hash, :text, null: false)
      add(:phone_number, :string, null: false)

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:phone_number])
  end
end

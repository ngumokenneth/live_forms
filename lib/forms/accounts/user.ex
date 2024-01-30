defmodule Forms.Accounts.User do
  @moduledoc """
  This module represents the user struct (schema) for working with the
  "users" table
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :name, :string
    field :email, :string
  end

  @doc """
  Returns a changeset for creating and/or editing a user
  """
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:email, :name])
    |> unique_constraint(:email, message: "email address entered is already in use")
  end
end

defmodule Forms.Accounts.User do
  @moduledoc """
  This module represents the user struct (schema) for working with the
  "users" table
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do

    field :email, :string
    field :password, :string
  end

  @doc """
  Returns a changeset for creating and/or editing a user
  """
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email, message: "email address entered is already in use")
  end

  @doc """
  This returns the changeset for login
  """
  def login_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
  end

  def registration_changeset(%__MODULE__{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
  end
end

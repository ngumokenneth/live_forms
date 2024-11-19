defmodule Invoices.Users.User do
  @moduledoc """
  This schema represents a single user of the system
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field(:email, :string)
    field(:password_hash, :string)
    field(:phone_number, :string)
    field(:password, :string, virtual: true, redact: true)

    timestamps()
  end

  @doc """
  Returns a changeset that is used to create a new user
  """
  def creation_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [
      :email,
      :password,
      :phone_number
    ])
    |> validate_required([
      :email,
      :phone_number,
      :password
    ])
    |> put_password_hash()
    |> unsafe_validate_unique(:email, Invoices.Repo, message: "Email address already in use")
    |> unique_constraint(:email, message: "Email address already in use")
    |> unique_constraint(:phone_number, message: "Phone number already in use")
  end

  defp put_password_hash(%{valid?: valid} = changeset) do
    hash = valid && get_change(changeset, :password)
    if hash, do: do_put_password_hash(changeset), else: changeset
  end

  defp do_put_password_hash(%{changes: %{password: password}} = changeset) do
    hash = Argon2.hash_pwd_salt(password)
    changeset |> put_change(:password_hash, hash) |> delete_change(:password)
  end
end

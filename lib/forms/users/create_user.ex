defmodule Invoices.Users.CreateUser do
  @moduledoc """
  Given params, it creates a new user
  """
  alias Invoices.Users.User

  @doc false
  def call(params) when is_map(params) do
    user = User.creation_changeset(params)
    Invoices.Repo.insert(user)
  end
end

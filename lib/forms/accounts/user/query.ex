defmodule Forms.Accounts.User.Query do
  @moduledoc """
  Defines all the queries for working with the User schema
  """
  import Ecto.Query, only: [where: 3]

  alias Forms.Accounts.User

  @doc "Returns the base query"
  def base, do: User

  @doc """
  Returns a query for a user with the given email address
  """
  def with_email(query \\ base(), email) do
    where(query, [u], u.email == ^email)
  end
end

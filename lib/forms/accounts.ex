defmodule Forms.Accounts do
  @moduledoc """
  Context file for working with accounts
  """
  alias Forms.Accounts.User
  alias Forms.Accounts.User.Query

  @doc """
  Logs in a user to their account
  """
  def login(%{"email" => email, "password" => _} = params) do
    with {:ok, user} <- user_with_email(email) do
      maybe_login_user(user, params)
    end
  end

  defp user_with_email(email) do
    query = Query.with_email(email)
    user = Forms.Repo.one(query)

    if user, do: {:ok, user}, else: {:error, :not_found}
  end

  defp maybe_login_user(user, %{"password" => password}) do
    similar? = user.password == password
    if similar?, do: {:ok, user}, else: {:error, :invalid_credentials}
  end

  @doc """
  Creates a changeset for login in a user
  """
  def change_user_for_login(user \\ %User{}, attrs \\ %{}) do
    User.login_changeset(user, attrs)
  end
end

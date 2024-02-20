defmodule Forms.AccountsTest do
  @moduledoc false
  use Forms.DataCase, async: true

  alias Forms.Accounts

  test "user logins successfully", _data do
    # 1. A user exists in the database
    # 2. Email address of user
    # 3. Password of user

    # create a user
    user = insert(:user)
    # params for loging in
    params = %{"email" => user.email, "password" => user.password}
    # check that user logged in successfully
    assert {:ok, _user} = Accounts.login(params)
  end

  test "user not found", _data do
    params = %{"email" => "doesexist@gmail.com", "password" => "!2343433"}
    assert {:error, :not_found} = Accounts.login(params)
  end

  test "invalid credentials", _data do
    user = insert(:user)
    params = %{"email" => user.email, "password" => "wrong password"}

    assert {:error, :invalid_credentials} = Accounts.login(params)
  end
end

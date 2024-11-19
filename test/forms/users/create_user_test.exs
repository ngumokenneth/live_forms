defmodule Invoices.Users.CreateUserTest do
  @moduledoc false
  use Invoices.DataCase, async: true

  alias Invoices.Users.CreateUser
  alias Invoices.Users.User

  describe "Create new user" do
    setup do
      params = %{
        "password" => "12345678",
        "email" => FakerElixir.Internet.email(),
        "phone_number" => FakerElixir.Phone.cell()
      }

      {:ok, user} = CreateUser.call(params)

      {:ok, user: user}
    end

    test "given valid user params, for a user that does not exists, a new user is successfully created" do
      params = %{
        "password" => "12345678",
        "email" => FakerElixir.Internet.email(),
        "phone_number" => FakerElixir.Phone.cell()
      }

      assert {:ok, _user} = CreateUser.call(params)

      query = where(User, [u], u.email == ^params["email"])
      assert Invoices.Repo.exists?(query)
    end

    test "given invalid params where required fields are not provided, a new user is not created" do
      params = %{"email" => FakerElixir.Internet.email()}
      assert {:error, _changeset} = CreateUser.call(params)

      query = where(User, [u], u.email == ^params["email"])
      refute Invoices.Repo.exists?(query)
    end

    test "given params with an email address that is already in use, a new user is not created and the changeset contains the error",
         %{
           user: user
         } do
      params = %{
        "email" => user.email,
        "password" => "12345678",
        "phone_number" => FakerElixir.Phone.cell()
      }

      assert {:error, changeset} = CreateUser.call(params)
      assert "Email address already in use" in errors_on(changeset).email

      query = where(User, [u], u.email == ^params["email"])
      assert [_user] = Invoices.Repo.all(query)
    end

    test "given params with a phone number that is already in use, a new user is not created and the changeset contain the phone number error",
         %{
           user: user
         } do
      params = %{
        "password" => "12345678",
        "email" => FakerElixir.Internet.email(),
        "phone_number" => user.phone_number
      }

      assert {:error, changeset} = CreateUser.call(params)
      assert "Phone number already in use" in errors_on(changeset).phone_number

      query = where(User, [u], u.phone_number == ^params["phone_number"])
      assert [_user] = Invoices.Repo.all(query)
    end
  end
end

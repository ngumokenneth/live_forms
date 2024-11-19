defmodule Invoices.Users.UserTest do
  @moduledoc false
  use Invoices.DataCase, async: true
  alias Invoices.Users.User

  describe "User Schema" do
    test "given the correct params, it returns a valid user changeset" do
      params = %{
        "email" => "random@gmail.com",
        "password" => "12345678",
        "phone_number" => "0723007987"
      }

      %{changes: changes} = changeset = User.creation_changeset(params)

      assert changeset.valid?
      assert changes[:password_hash]
      assert changes[:email] == params["email"]
      assert changes[:phone_number] == params["phone_number"]

      refute changes[:password]
    end

    test "given params that do not contain any of the required fields, it returns an invalid changeset" do
      changeset = User.creation_changeset(%{})

      assert changeset.valid? == false
      assert "can't be blank" in errors_on(changeset).email
      assert "can't be blank" in errors_on(changeset).password
      assert "can't be blank" in errors_on(changeset).phone_number
    end
  end
end

defmodule FormsWeb.UserRegistrationLiveTest do
  use FormsWeb.ConnCase, async: true

  describe "user registration form" do
    test "a user will see the input fields", %{conn: conn} do
      {:ok, view, html} = live(conn, ~p"/register")

      assert html =~ "Create an Account"

      name_field = element(view, "input#user_name")
      assert has_element?(name_field)

      email_field = element(view, "input#user_email")
      assert has_element?(email_field)

      password_field = element(view, "input#user_password")
      assert has_element?(password_field)
    end
  end
end

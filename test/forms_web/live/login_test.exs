defmodule FormsWeb.LoginTest do
  @moduledoc false
  use FormsWeb.ConnCase, async: true

  describe "Login page" do
    test "given the user visits the login page, they should see the login form with all the required inputs",
         %{
           conn: conn
         } do
      {:ok, view, html} = live(conn, ~p"/login")
      assert html =~ "Login to your account"

      # get email input field
      email_input = element(view, "input#login_email")
      assert has_element?(email_input)

      ## TODO: Write test that asserts the existence of the password field
    end
  end
end

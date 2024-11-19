defmodule Invoices.UserFactory do
  @moduledoc false
  use ExMachina.Ecto, repo: Invoices.Repo

  @doc false
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Invoices.Users.User{
          email: FakerElixir.Internet.email(),
          phone_number: FakerElixir.Phone.cell(),
          password_hash: Ecto.UUID.generate()
        }
      end
    end
  end
end

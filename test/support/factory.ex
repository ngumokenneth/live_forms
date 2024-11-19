defmodule Forms.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Forms.Repo

  alias Forms.Accounts.User
  alias FakerElixir, as: Faker

  def user_factory do
    %User{
      email: Faker.Internet.email(),
      password: "1234567890"
    }
  end
end

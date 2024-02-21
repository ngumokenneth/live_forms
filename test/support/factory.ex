defmodule Forms.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Forms.Repo

  alias Forms.Accounts.User
  alias FakerElixir, as: Faker

  def user_factory do
    %User{
      email: Faker.Internet.email(),
      name: Faker.Name.name(),
      password: "1234567890"
    }
  end
end

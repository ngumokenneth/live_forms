defmodule Forms.Repo.Migrations.AddUsersToDb do
  @moduledoc false
  use Ecto.Migration
  alias __MODULE__.User

  Application.ensure_all_started(:faker_elixir_octopus)

  def up do
    func = fn repo ->
      params =
        [
          %{
            name: FakerElixir.Name.name(),
            email: "okari@gmail.com",
            password: "1234567890"
          },
          %{
            name: FakerElixir.Name.name(),
            email: "ken@gmail.com",
            password: "1234567890"
          }
        ]

      repo.insert_all(User, params, [])
    end

    Forms.Repo.transaction(func)
  end
end

defmodule Forms.Repo.Migrations.AddUsersToDb.User do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:password, :string)
  end
end

{:ok, _pid} = Application.ensure_all_started(:ex_machina)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Forms.Repo, :manual)

defmodule PhoenixTodoApp.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_todo_app,
    adapter: Ecto.Adapters.Postgres
end

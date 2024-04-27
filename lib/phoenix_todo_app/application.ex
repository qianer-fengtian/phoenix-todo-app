defmodule PhoenixTodoApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixTodoAppWeb.Telemetry,
      PhoenixTodoApp.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_todo_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixTodoApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixTodoApp.Finch},
      # Start a worker by calling: PhoenixTodoApp.Worker.start_link(arg)
      # {PhoenixTodoApp.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixTodoAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixTodoApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixTodoAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

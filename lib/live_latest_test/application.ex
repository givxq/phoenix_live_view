defmodule LiveLatestTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      LiveLatestTest.Repo,
      # Start the Telemetry supervisor
      LiveLatestTestWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveLatestTest.PubSub},
      # Start the Endpoint (http/https)
      LiveLatestTestWeb.Endpoint
      # Start a worker by calling: LiveLatestTest.Worker.start_link(arg)
      # {LiveLatestTest.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveLatestTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveLatestTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

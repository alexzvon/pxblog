defmodule Pxblog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PxblogWeb.Telemetry,
      Pxblog.Repo,
      {DNSCluster, query: Application.get_env(:pxblog, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Pxblog.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Pxblog.Finch},
      # Start a worker by calling: Pxblog.Worker.start_link(arg)
      # {Pxblog.Worker, arg},
      # Start to serve requests, typically the last entry
      PxblogWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pxblog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PxblogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

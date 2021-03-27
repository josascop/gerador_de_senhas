defmodule GeradorDeSenhas.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GeradorDeSenhasWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GeradorDeSenhas.PubSub},
      # Start the Endpoint (http/https)
      GeradorDeSenhasWeb.Endpoint,
      # para passar um módulo que não use GenServer como filho
      %{
        id: GeradorDeSenhas.Logica,
        start: {GeradorDeSenhas.Logica, :start_link, []}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GeradorDeSenhas.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GeradorDeSenhasWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

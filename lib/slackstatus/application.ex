defmodule Slackstatus.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Slackstatus.Worker.start_link(arg)
      # {Slackstatus.Worker, arg},
    ]

    :timer.apply_interval(1000 * 60 * 5, Slackstatus, :changeStatus, [])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Slackstatus.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

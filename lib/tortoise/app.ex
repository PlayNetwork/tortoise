defmodule Tortoise.App do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # read configuration and start connections
    # start with client_id, and handler from config

    children = [
      {Registry, [keys: :unique, name: Tortoise.Registry, partitions: System.schedulers_online()]},
      {Registry, [keys: :duplicate, name: Tortoise.Events, partitions: System.schedulers_online()]},
      {Tortoise.Supervisor, [strategy: :one_for_one]}
    ]

    opts = [strategy: :one_for_one, name: Tortoise]
    Supervisor.start_link(children, opts)
  end
end

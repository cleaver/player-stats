# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :player_stats,
  ecto_repos: [PlayerStats.Repo]

# Configures the endpoint
config :player_stats, PlayerStatsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8Us/yDfDu/QqafwrA+NtopN5Rcm/jJ3x71VWDwl8mvS6RjKlz+1yRi25Y7VLtZ1s",
  render_errors: [view: PlayerStatsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PlayerStats.PubSub,
  live_view: [signing_salt: "MLqy/Sng"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

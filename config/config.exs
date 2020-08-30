# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phx_fast_stack,
  ecto_repos: [PhxFastStack.Repo]

# Configures the endpoint
config :phx_fast_stack, PhxFastStackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UdHNPLYWaiXQbaCdhW6RaxrjdIHOI3GtlHQH4qjLN0FjHh44YVuoKCm/JvPacQ2B",
  render_errors: [view: PhxFastStackWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhxFastStack.PubSub,
  live_view: [signing_salt: "1aOYwQjW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use Pow for authentication
config :phx_fast_stack, :pow,
  user: PhxFastStack.Users.User,
  repo: PhxFastStack.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

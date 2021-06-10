# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ranker,
  ecto_repos: [Ranker.Repo]

# Configures the endpoint
config :ranker, RankerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7zqAXnWcOEUQao3aMKoroNfDo8w/51/Roaar9AjLsG0Ua6UY9mwclF7fvqFwEXIf",
  render_errors: [view: RankerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ranker.PubSub,
  live_view: [signing_salt: "2jCJNjCe"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"]
    ]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

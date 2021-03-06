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
    github: { Ueberauth.Strategy.Github, [] },
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

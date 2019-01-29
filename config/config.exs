# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :pocket_reducer, PocketReducerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("POCKET_REDUCER_SECRET_KEY_BASE"),
  render_errors: [view: PocketReducerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PocketReducer.PubSub, adapter: Phoenix.PubSub.PG2]

config :pocket_reducer,
  api_key: System.get_env("POCKET_REDUCER_API_KEY"),
  url: System.get_env("POCKET_REDUCER_URL"),
  url_callback: System.get_env("POCKET_REDUCER_URL_CALLBACK")

# Configures Drab
config :drab, PocketReducerWeb.Endpoint, otp_app: :pocket_reducer

config :drab, timeout: :infinity

# Configures default Drab file extension
config :phoenix, :template_engines, drab: Drab.Live.Engine

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

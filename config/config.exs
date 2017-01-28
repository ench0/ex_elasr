# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elasr,
  ecto_repos: [Elasr.Repo]

# Configures the endpoint
config :elasr, Elasr.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ojqxq2iz0KS7aXdJq+D1nvl9aJMrdSU1XylvSf9XSg5znqEaMPyzjlcEK/+tX+i/",
  render_errors: [view: Elasr.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Elasr.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Slugger
# Char used as separator between words.
config :slugger, separator_char: ?-
# Path to the file containing replacements.
config :slugger, replacement_file: "replacements.exs"

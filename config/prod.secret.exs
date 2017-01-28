use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :elasr, Elasr.Endpoint,
  secret_key_base: "cYNHp+VX111SiDeKZ+FPc4MbjzzA/y8NhE6s1Tz0p5st6P6zRCxVYX0lVmlNBOzY"

# Configure your database
config :elasr, Elasr.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "elasr_prod",
  pool_size: 20

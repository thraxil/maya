defmodule Maya.Repo do
  use Ecto.Repo,
    otp_app: :maya,
    adapter: Ecto.Adapters.Postgres
end

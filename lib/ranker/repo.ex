defmodule Ranker.Repo do
  use Ecto.Repo,
    otp_app: :ranker,
    adapter: Ecto.Adapters.Postgres
end

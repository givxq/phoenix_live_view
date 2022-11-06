defmodule LiveLatestTest.Repo do
  use Ecto.Repo,
    otp_app: :live_latest_test,
    adapter: Ecto.Adapters.Postgres
end

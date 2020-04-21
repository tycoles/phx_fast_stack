defmodule PhxFastStack.Repo do
  use Ecto.Repo,
    otp_app: :phx_fast_stack,
    adapter: Ecto.Adapters.Postgres
end

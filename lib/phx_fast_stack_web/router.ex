defmodule PhxFastStackWeb.Router do
  use PhxFastStackWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {PhxFastStackWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxFastStackWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/demo-live", DemoLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxFastStackWeb do
  #   pipe_through :api
  # end
end
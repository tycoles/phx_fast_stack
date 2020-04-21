defmodule PhxFastStackWeb.Router do
  use PhxFastStackWeb, :router
  use Pow.Phoenix.Router
  use PowAssent.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {PhxFastStackWeb.LayoutView, :root}
  end

  pipeline :skip_csrf_protection do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :skip_csrf_protection

    pow_assent_authorization_post_callback_routes()
  end

  scope "/" do
    pipe_through [:browser]

    get "/", PhxFastStackWeb.PageController, :index
    live "/demo-live", PhxFastStackWeb.DemoLive

    pow_routes()
    pow_assent_routes()
  end

  scope "/", PhxFastStackWeb do
    pipe_through [:browser, :protected]

    # Protected routes ...
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxFastStackWeb do
  #   pipe_through :api
  # end
end

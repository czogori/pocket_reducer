defmodule PocketReducerWeb.Router do
  use PocketReducerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", PocketReducerWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/auth", PageController, :auth)
    get("/callback", PageController, :callback)
  end

  # Other scopes may use custom stacks.
  # scope "/api", PocketReducerWeb do
  #   pipe_through :api
  # end
end

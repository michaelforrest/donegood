defmodule Donegood.Router do
  use Donegood.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end
  # auth stuff copied from https://github.com/wafcio/screencast_aggregator
  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", Donegood do
    pipe_through [:browser, :browser_auth]

    get "/logout", AuthController, :logout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  scope "/", Donegood do
    pipe_through [:browser, :browser_auth]

    get "/", PageController, :index
    get "/welcome", PageController, :welcome
    resources "/users", UserController
    resources "/deeds", DeedController
    resources "/wellbeings", WellbeingController
  end

  scope "/api", Donegood do
    pipe_through :api

    get "/stuff", StuffController, :index
  end
end

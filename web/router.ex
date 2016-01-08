defmodule Donegood.Router do
  use Donegood.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Donegood do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/deeds", DeedController
  end

  scope "/api", Donegood do
    pipe_through :api

    get "/stuff", StuffController, :index
  end
end

defmodule Donegood.PageController do
  use Donegood.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, %{ handler: Donegood.AuthErrorHandler, typ: "token" } when not action in [:index]

  def index(conn, _params, current_user, _claims) do
    if current_user do
      redirect(conn, to: "/welcome")
    else
      render conn, "index.html", current_user: current_user
    end
  end

  def welcome(conn, _params, current_user, _claims) do
    conn
    |> render :welcome, current_user: current_user
  end
end

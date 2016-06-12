defmodule Donegood.PageController do
  use Donegood.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, %{ handler: Donegood.AuthErrorHandler, typ: "token" } when not action in [:index]

  def index(conn, _params, current_user, _claims) do
    render conn, "index.html", current_user: current_user
  end
  def friend_search(conn, %{"search"=>%{"query" => query}}, current_user, _claims) do
    results = []
    render conn, "friend_search.html", current_user: current_user, results: results
  end

end

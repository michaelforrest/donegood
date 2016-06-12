defmodule Donegood.ProfileController do
  use Donegood.Web, :controller
  alias Donegood.{Repo,User}
  plug Guardian.Plug.EnsureAuthenticated, %{ handler: Donegood.AuthErrorHandler, typ: "token" }

  def show(conn, %{"id" => id}, current_user, _claims) do
    IO.inspect id
    IO.inspect current_user
    user = Repo.get(User, id) |> Repo.preload([:wellbeings, :deeds])
    if id == "#{current_user.id}" do
       render conn, "show.html",
        user: user,
        current_user: current_user

    else
      redirect conn, to: "/"
    end
  end

end

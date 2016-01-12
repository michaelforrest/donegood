defmodule Donegood.PageController do
  use Donegood.Web, :controller

  def index(conn, _params, current_user, _claims) do
    conn
    # |> put_flash(:error, "Blast it!")
    # |> put_flash(:info, "Rockets.")
    |> render "index.html", current_user: current_user
  end
end

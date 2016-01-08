defmodule Donegood.PageController do
  use Donegood.Web, :controller

  def index(conn, _params) do
    conn
    # |> put_flash(:error, "Blast it!")
    # |> put_flash(:info, "Rockets.")
    |> render "index.html"
  end
end

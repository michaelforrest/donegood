defmodule Donegood.PageController do
  use Donegood.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

defmodule Donegood.StuffController do
  use Donegood.Web, :controller

  def index(conn, _params) do
    conn
    |> json %{thing: 'Hello'}
  end
end

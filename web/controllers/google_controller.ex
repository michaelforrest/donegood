defmodule Donegood.GoogleController do
  use Donegood.Web, :controller
  alias Goth.Token
  plug Guardian.Plug.EnsureAuthenticated, %{ handler: Donegood.AuthErrorHandler, typ: "token" }

  def friend_picker(conn, params, current_user, _claims) do
    # token = case Token.for_scope("https://www.googleapis.com/auth/contacts.readonly") do
    #   {:ok, token } -> token
    # end
    # IO.inspect token
    token = %{type: "Bearer", token: current_user.google_id }
    url = "https://www.google.com/m8/feeds/groups/michael.forrest@gmail.com/all"
    {status, response} =  HTTPoison.get(url, [{"Authorization", "#{token.type} #{token.token}"}], [alt: "json"])
    if response.status_code == 401 do
      html(conn, "<h1>FROM GOOGLE</h1>#{response.body}")
    else
      render(conn, "friend_picker.html", current_user: current_user)
    end
  end
end

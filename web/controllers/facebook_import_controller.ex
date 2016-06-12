defmodule Donegood.FacebookImportController do
  use Donegood.Web, :controller
  def new(conn, _params, current_user, _claims) do
    IO.inspect current_user:  current_user
    friends = case HTTPoison.get "https://graph.facebook.com/v2.6/me/friends",[],params: [access_token: current_user.facebook_token] do
      {:ok, response}-> Poison.decode!(response.body)["data"]
    end
    IO.inspect friends
    render(conn, "new.html", current_user: current_user, facebook_friends: friends)
  end
end

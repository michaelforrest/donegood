defmodule Donegood.UserFromAuth do
  alias Donegood.User
  alias Donegood.Repo
  alias Ueberauth.Auth

  def find_or_create(auth) do
    case auth_and_validate(auth) do
      nil -> create_user_from_auth(auth)
      user -> {:ok, user}
      {:error, reason} -> {:error, reason}
    end
  end


  # %Ueberauth.Auth{credentials: %Ueberauth.Auth.Credentials{expires: true,
  #  expires_at: 5113476, other: %{}, refresh_token: nil, scopes: [""],
  #  secret: nil,
  #  token: "EAAFiIZCxjaS4BAGFzVbmDqVZCHT6psNAZCzgQNwzIS0aZBPfUqCDGvpxA3PJGZBoM4I7GJwuApuVqZBE8TpECUs7IkBIJ7xw4v78WiiHeGtOi43imFpUwarlLlc8Ea34g2FsMjQ19CJr6WFiiX4Rkqa3hCDN7GZCnMZD",
  #  token_type: nil},
  # extra: %Ueberauth.Auth.Extra{raw_info: %{token: %OAuth2.AccessToken{access_token: "EAAFiIZCxjaS4BAGFzVbmDqVZCHT6psNAZCzgQNwzIS0aZBPfUqCDGvpxA3PJGZBoM4I7GJwuApuVqZBE8TpECUs7IkBIJ7xw4v78WiiHeGtOi43imFpUwarlLlc8Ea34g2FsMjQ19CJr6WFiiX4Rkqa3hCDN7GZCnMZD",
  #     client: %OAuth2.Client{authorize_url: "https://www.facebook.com/dialog/oauth",
  #      client_id: "389381674461486",
  #      client_secret: "94a84b1b95059bf694f91246681c8943",
  #      headers: [{"Content-Type", "application/x-www-form-urlencoded"},
  #       {"Accept", "application/json"}],
  #      params: %{"client_id" => "389381674461486",
  #        "client_secret" => "94a84b1b95059bf694f91246681c8943",
  #        "code" => "AQBrtz_W7Tw1Ixg8doTknZqgfDQo0zmn1w1B81xPDmgetJJZzBr4JkMLMZo6S0_iFj-Du8r0P1uMOSxETOTgYgf8KCx8AJjn2HKrSEiy7V2H8S6w0VjYnwC6GfDvhmw545MQR6vq0zqwljI7zlyq1-vdiSEec_xj9wgCUwsxCxk6ciCQLqDz1lvP-fvVLKsgZnJjvEPPAio5IOEmt0gxglF-s1ifrDv1a44_W44z31F-aSqFfs6npaB_gh05bqhht4RdwY_vKa3gjdL7SOVi-g7S32yeQ4YXgRZjVx1dyVuVR5aOwUkGsYu0nK1ZZjTer74",
  #        "grant_type" => "authorization_code",
  #        "redirect_uri" => "http://localhost:4015/auth/facebook/callback"},
  #      redirect_uri: "http://localhost:4015/auth/facebook/callback",
  #      site: "https://graph.facebook.com",
  #      strategy: Ueberauth.Strategy.Facebook.OAuth, token_method: :post,
  #      token_url: "/oauth/access_token"}, expires_at: 5113476,
  #     other_params: %{"expires" => "5113476"}, refresh_token: nil,
  #     token_type: "Bearer"},
  #    user: %{"email" => "michael.forrest@gmail.com", "first_name" => "Michael",
  #      "gender" => "male", "id" => "906075596", "last_name" => "Forrest",
  #      "link" => "https://www.facebook.com/app_scoped_user_id/906075596/",
  #      "locale" => "en_US", "name" => "Michael Forrest", "timezone" => 1,
  #      "updated_time" => "2016-05-03T22:28:42+0000", "verified" => true}}},
  # info: %Ueberauth.Auth.Info{description: nil,
  #  email: "michael.forrest@gmail.com", first_name: "Michael",
  #  image: "http://graph.facebook.com/906075596/picture?type=square",
  #  last_name: "Forrest", location: nil, name: "Michael Forrest", nickname: nil,
  #  phone: nil,
  #  urls: %{facebook: "https://www.facebook.com/app_scoped_user_id/906075596/",
  #    website: nil}}, provider: :facebook, strategy: Ueberauth.Strategy.Facebook,
  # uid: "906075596"}
  defp create_user_from_auth(%{provider: :facebook } = auth) do # do pattern matching in the auth bit? I think so...
    # IO.inspect(auth_info: auth)
    User.changeset(%User{}, %{
      name: auth.info.name,
      email: auth.info.email,
      facebook_id: auth.uid,})
    |> Repo.insert
  end

  defp create_user_from_auth(%{provider: :twitter} = auth) do # do pattern matching in the auth bit? I think so...
    User.changeset(%User{}, %{name: auth.info.name, twitter_id: auth.uid})
    |> Repo.insert
  end

  defp create_user_from_auth(%{provider: :google} = auth) do
    IO.inspect auth
    User.changeset(%User{}, %{name: auth.info.name, google_id: auth.uid, google_token: auth.credentials.token})
    |> Repo.insert
  end

  defp auth_and_validate(%{provider: :facebook} = auth) do
    user = Repo.get_by(User, facebook_id: auth.uid)
    Repo.update(User.changeset(user, %{facebook_token: auth.credentials.token} ))
    user
  end

  defp auth_and_validate(%{provider: :twitter} = auth) do
    Repo.get_by(User, twitter_id: auth.uid)
  end

  defp auth_and_validate(%{provider: :google} = auth) do
    Repo.get_by(User, google_id: auth.uid)
  end

  defp auth_and_validate(_auth), do: {:error, "Unsupported provider"}
end

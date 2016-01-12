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

  defp create_user_from_auth(auth) do # do pattern matching in the auth bit? I think so...
    User.changeset(%User{}, %{name: auth.info.name, email: auth.info.email, facebook_id: auth.uid})
    |> Repo.insert
  end

  defp auth_and_validate(%{provider: :facebook} = auth) do
    Repo.get_by(User, facebook_id: auth.uid)
  end

  defp auth_and_validate(_auth), do: {:error, "Unsupported provider"}
end

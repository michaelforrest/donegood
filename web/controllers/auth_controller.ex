defmodule Donegood.AuthController do
  use Donegood.Web, :controller
  use Guardian.Phoenix.Controller

  alias Donegood.UserFromAuth

  require Ueberauth

  plug Ueberauth, base_path: "/auth"

  def callback(%Plug.Conn{ assigns: %{ ueberauth_failure: fails } } = conn, _params, current_user, _claims) do
    conn
    |> put_flash(:error, "Failed to authenticate")
    |> redirect(to: "/")
  end

  def callback(%Plug.Conn{ assigns: %{ ueberauth_auth: auth } } = conn, _params, current_user, _claims) do
    case UserFromAuth.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Signed in as #{user.name}")
        |> Guardian.Plug.sign_in(user, :token, perms: %{default: Guardian.Permissions.max})
        |> redirect(to: "/")
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Could not authenticate because #{_reason}")
        |> redirect(to: "/")
    end
  end

  def logout(conn, _params, current_user, _claims) do
    if current_user do
      conn
      |> Guardian.Plug.sign_out
      |> put_flash(:info, "Signed out")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:info, "Not logged in")
      |> redirect(to: "/")
    end

  end
end

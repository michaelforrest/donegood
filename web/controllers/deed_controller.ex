defmodule Donegood.DeedController do
  use Donegood.Web, :controller

  alias Donegood.Deed

  plug Guardian.Plug.EnsureAuthenticated, %{ handler: Donegood.AuthErrorHandler, typ: "token" }
  plug :scrub_params, "deed" when action in [:create, :update]

  def index(conn, _params, current_user, _claims) do
    deeds = Repo.all(Deed)
    render(conn, "index.html", deeds: deeds)
  end

  def new(conn, _params, current_user, _claims) do
    changeset = Deed.changeset(%Deed{
      user_id: current_user.id,
      when: Ecto.Date.utc
      })
    render(conn, "new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"deed" => deed_params}, current_user, _claims) do

    params = Map.merge deed_params, %{
      "location" => deed_params["location_data"],
      "created_by_user_id" => current_user.id
     }
    changeset = Deed.changeset(%Deed{}, params)
    IO.inspect changeset
    case Repo.insert(changeset) do
      {:ok, _deed} ->
        conn
        |> put_flash(:info, "Deed created successfully.")
        |> redirect(to: "/")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user)
    end
  end

  def show(conn, %{"id" => id}, current_user, _claims) do
    deed = Repo.get!(Deed, id)
    render(conn, "show.html", deed: deed, current_user: current_user)
  end

  def edit(conn, %{"id" => id}, current_user, _claims) do
    deed = Repo.get!(Deed, id)
    changeset = Deed.changeset(deed)
    render(conn, "edit.html", deed: deed, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "deed" => deed_params}, current_user, _claims) do
    deed = Repo.get!(Deed, id)
    changeset = Deed.changeset(deed, deed_params)

    case Repo.update(changeset) do
      {:ok, deed} ->
        conn
        |> put_flash(:info, "Deed updated successfully.")
        |> redirect(to: deed_path(conn, :show, deed))
      {:error, changeset} ->
        render(conn, "edit.html", deed: deed, changeset: changeset, current_user: current_user)
    end
  end

  def delete(conn, %{"id" => id}, current_user, _claims) do
    deed = Repo.get!(Deed, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(deed)

    conn
    |> put_flash(:info, "Deed deleted successfully.")
    |> redirect(to: deed_path(conn, :index))
  end
end

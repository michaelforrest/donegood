defmodule Donegood.DeedController do
  use Donegood.Web, :controller

  alias Donegood.Deed

  plug Guardian.Plug.EnsureAuthenticated, %{ handler: Donegood.AuthErrorHandler, typ: "token" }
  plug :scrub_params, "deed" when action in [:create, :update]
  

  def new(conn, _params, current_user, _claims) do
    render(conn, "new.html", current_user: current_user)
  end

  def index(conn, _params) do
    deeds = Repo.all(Deed)
    render(conn, "index.json", deeds: deeds)
  end

  def create(conn, %{"deed" => deed_params}) do
    changeset = Deed.changeset(%Deed{}, deed_params)

    case Repo.insert(changeset) do
      {:ok, deed} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", deed_path(conn, :show, deed))
        |> render("show.json", deed: deed)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Donegood.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    deed = Repo.get!(Deed, id)
    render(conn, "show.json", deed: deed)
  end

  def update(conn, %{"id" => id, "deed" => deed_params}) do
    deed = Repo.get!(Deed, id)
    changeset = Deed.changeset(deed, deed_params)

    case Repo.update(changeset) do
      {:ok, deed} ->
        render(conn, "show.json", deed: deed)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Donegood.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deed = Repo.get!(Deed, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(deed)

    send_resp(conn, :no_content, "")
  end
end

defmodule Donegood.WellbeingController do
  use Donegood.Web, :controller

  alias Donegood.Wellbeing

  plug :scrub_params, "wellbeing" when action in [:create, :update]

  def index(conn, _params) do
    wellbeings = Repo.all(Wellbeing)
    render(conn, "index.json", wellbeings: wellbeings)
  end

  def new(conn, _params, current_user, _claims) do
    changeset = Wellbeing.changeset(%Wellbeing{ user: current_user })
    render(conn, "new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"wellbeing" => wellbeing_params}) do
    changeset = Wellbeing.changeset(%Wellbeing{}, wellbeing_params)

    case Repo.insert(changeset) do
      {:ok, wellbeing} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", wellbeing_path(conn, :show, wellbeing))
        |> render("show.json", wellbeing: wellbeing)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Donegood.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    wellbeing = Repo.get!(Wellbeing, id)
    render(conn, "show.json", wellbeing: wellbeing)
  end

  def update(conn, %{"id" => id, "wellbeing" => wellbeing_params}) do
    wellbeing = Repo.get!(Wellbeing, id)
    changeset = Wellbeing.changeset(wellbeing, wellbeing_params)

    case Repo.update(changeset) do
      {:ok, wellbeing} ->
        render(conn, "show.json", wellbeing: wellbeing)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Donegood.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    wellbeing = Repo.get!(Wellbeing, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(wellbeing)

    send_resp(conn, :no_content, "")
  end
end

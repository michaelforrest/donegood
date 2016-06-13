defmodule Donegood.IdeaController do
  use Donegood.Web, :controller

  alias Donegood.Idea

  plug :scrub_params, "idea" when action in [:create, :update]

  def index(conn, _params, current_user, _claims) do
    ideas = Repo.preload(current_user, :ideas).ideas
    render(conn, "index.html", ideas: ideas, current_user: current_user)
  end

  def new(conn, _params, current_user, _claims) do
    changeset = Idea.changeset(%Idea{})
    render(conn, "new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"idea" => idea_params}, current_user, _claims) do
    idea_params = Map.put(idea_params, "user_id", current_user.id)
    changeset = Idea.changeset(%Idea{}, idea_params)
    case Repo.insert(changeset) do
      {:ok, _idea} ->
        conn
        |> put_flash(:info, "Idea created successfully.")
        |> redirect(to: idea_path(conn, :index))
      {:error, changeset} ->
        IO.inspect changeset
        render(conn, "new.html", changeset: changeset, current_user: current_user)
    end
  end

  def show(conn, %{"id" => id}, current_user, _claims) do
    idea = Repo.get!(Idea, id)
    render(conn, "show.html", idea: idea)
  end

  def edit(conn, %{"id" => id}, current_user, _claims) do
    idea = Repo.get!(Idea, id)
    changeset = Idea.changeset(idea)
    render(conn, "edit.html", idea: idea, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "idea" => idea_params}, current_user, _claims) do
    idea = Repo.get!(Idea, id)
    idea_params = Map.put(idea_params, "user_id", current_user.id)
    changeset = Idea.changeset(idea, idea_params)

    case Repo.update(changeset) do
      {:ok, idea} ->
        conn
        |> put_flash(:info, "Idea updated successfully.")
        |> redirect(to: idea_path(conn, :show, idea))
      {:error, changeset} ->
        render(conn, "edit.html", idea: idea, changeset: changeset, current_user: current_user)
    end
  end

  def delete(conn, %{"id" => id}, current_user, _claims) do
    idea = Repo.get!(Idea, id) |> Repo.preload(:user)
    if idea.user != current_user do
      raise "Oh no you don't"
    end
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(idea)

    conn
    |> put_flash(:info, "Idea deleted successfully.")
    |> redirect(to: idea_path(conn, :index))
  end
end

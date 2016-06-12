defmodule Donegood.WellbeingController do
  use Donegood.Web, :controller

  alias Donegood.Wellbeing

  plug :scrub_params, "wellbeing" when action in [:create, :update]


  def new(conn, _params, current_user, _claims) do
    changeset = Wellbeing.changeset(%Wellbeing{})
    render(conn, "new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"wellbeing" => wellbeing_params}, current_user, _claims) do
    notes = Enum.filter wellbeing_params, fn({key,value}) -> String.ends_with?(key,"-note") && value != nil end
    # we're gonna take everything with a `-note` suffix and turn it into a child array
    # in the format for WellbeingNote
    params = Map.merge wellbeing_params, %{
      "user_id" => current_user.id,
      "notes" => Enum.map(notes, fn({key,value}) -> %{
         "field" => String.replace( key, "-note", ""),
         "text" => String.strip(value)
       } end)
    }
    changeset = Wellbeing.changeset %Wellbeing{}, params
    # raise "oops"
    case Repo.insert(changeset) do
      {:ok, _wellbeing} ->
        conn
        |> put_flash(:info, "Saved!")
        |> redirect(to: "/")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

defmodule Donegood.WellbeingController do
  use Donegood.Web, :controller

  alias Donegood.Wellbeing

  plug :scrub_params, "wellbeing" when action in [:create, :update]


  def new(conn, _params, current_user, _claims) do
    changeset = Wellbeing.changeset(%Wellbeing{ user: current_user })
    render(conn, "new.html", changeset: changeset, current_user: current_user)
  end


end

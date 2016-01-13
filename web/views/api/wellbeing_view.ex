defmodule Donegood.Api.WellbeingView do
  use Donegood.Web, :view

  def render("index.json", %{wellbeings: wellbeings}) do
    %{data: render_many(wellbeings, Donegood.Api.WellbeingView, "wellbeing.json")}
  end

  def render("show.json", %{wellbeing: wellbeing}) do
    %{data: render_one(wellbeing, Donegood.Api.WellbeingView, "wellbeing.json")}
  end

  def render("wellbeing.json", %{wellbeing: wellbeing}) do
    %{id: wellbeing.id,
      appreciated: wellbeing.appreciated,
      well_liked: wellbeing.well_liked,
      user_id: wellbeing.user_id}
  end
end

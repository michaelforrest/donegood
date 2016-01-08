defmodule Donegood.DeedView do
  use Donegood.Web, :view

  def render("index.json", %{deeds: deeds}) do
    %{data: render_many(deeds, Donegood.DeedView, "deed.json")}
  end

  def render("show.json", %{deed: deed}) do
    %{data: render_one(deed, Donegood.DeedView, "deed.json")}
  end

  def render("deed.json", %{deed: deed}) do
    %{id: deed.id,
      title: deed.title,
      body: deed.body,
      duration: deed.duration,
      user_id: deed.user_id}
  end
end

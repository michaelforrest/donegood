defmodule Donegood.WellbeingControllerTest do
  use Donegood.ConnCase

  alias Donegood.Wellbeing
  @valid_attrs %{appreciated: 42, well_liked: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, wellbeing_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    wellbeing = Repo.insert! %Wellbeing{}
    conn = get conn, wellbeing_path(conn, :show, wellbeing)
    assert json_response(conn, 200)["data"] == %{"id" => wellbeing.id,
      "appreciated" => wellbeing.appreciated,
      "well_liked" => wellbeing.well_liked,
      "user_id" => wellbeing.user_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, wellbeing_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, wellbeing_path(conn, :create), wellbeing: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Wellbeing, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, wellbeing_path(conn, :create), wellbeing: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    wellbeing = Repo.insert! %Wellbeing{}
    conn = put conn, wellbeing_path(conn, :update, wellbeing), wellbeing: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Wellbeing, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    wellbeing = Repo.insert! %Wellbeing{}
    conn = put conn, wellbeing_path(conn, :update, wellbeing), wellbeing: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    wellbeing = Repo.insert! %Wellbeing{}
    conn = delete conn, wellbeing_path(conn, :delete, wellbeing)
    assert response(conn, 204)
    refute Repo.get(Wellbeing, wellbeing.id)
  end
end

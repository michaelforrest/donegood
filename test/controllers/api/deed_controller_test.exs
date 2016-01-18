defmodule Donegood.Api.DeedControllerTest do
  use Donegood.ConnCase

  alias Donegood.{Deed, User}
  @valid_attrs %{body: "some content", duration: 42, title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
    Repo.insert! %User{email: "user@example.com"}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, deed_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    deed = Repo.insert! %Deed{}
    conn = get conn, deed_path(conn, :show, deed)
    assert json_response(conn, 200)["data"] == %{"id" => deed.id,
      "title" => deed.title,
      "body" => deed.body,
      "duration" => deed.duration,
      "user_id" => deed.user_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, deed_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, deed_path(conn, :create), deed: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Deed, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, deed_path(conn, :create), deed: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    deed = Repo.insert! %Deed{}
    conn = put conn, deed_path(conn, :update, deed), deed: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Deed, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    deed = Repo.insert! %Deed{}
    conn = put conn, deed_path(conn, :update, deed), deed: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user = Repo.get_by(Deed, email: "text@example.com")
    deed = Repo.insert! %Deed{}
    conn = delete conn, deed_path(conn, :delete, deed)
    assert response(conn, 204)
    refute Repo.get(Deed, deed.id)
  end
end

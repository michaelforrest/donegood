defmodule Donegood.DeedControllerTest do
  use Donegood.ConnCase

  alias Donegood.Deed
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, deed_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing deeds"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, deed_path(conn, :new)
    assert html_response(conn, 200) =~ "New deed"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, deed_path(conn, :create), deed: @valid_attrs
    assert redirected_to(conn) == deed_path(conn, :index)
    assert Repo.get_by(Deed, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, deed_path(conn, :create), deed: @invalid_attrs
    assert html_response(conn, 200) =~ "New deed"
  end

  test "shows chosen resource", %{conn: conn} do
    deed = Repo.insert! %Deed{}
    conn = get conn, deed_path(conn, :show, deed)
    assert html_response(conn, 200) =~ "Show deed"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, deed_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    deed = Repo.insert! %Deed{}
    conn = get conn, deed_path(conn, :edit, deed)
    assert html_response(conn, 200) =~ "Edit deed"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    deed = Repo.insert! %Deed{}
    conn = put conn, deed_path(conn, :update, deed), deed: @valid_attrs
    assert redirected_to(conn) == deed_path(conn, :show, deed)
    assert Repo.get_by(Deed, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    deed = Repo.insert! %Deed{}
    conn = put conn, deed_path(conn, :update, deed), deed: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit deed"
  end

  test "deletes chosen resource", %{conn: conn} do
    deed = Repo.insert! %Deed{}
    conn = delete conn, deed_path(conn, :delete, deed)
    assert redirected_to(conn) == deed_path(conn, :index)
    refute Repo.get(Deed, deed.id)
  end
end

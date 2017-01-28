defmodule Elasr.BrojControllerTest do
  use Elasr.ConnCase

  alias Elasr.Broj
  @valid_attrs %{fajl: "some content", naslov: "some content", slika: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, broj_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing brojevi"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, broj_path(conn, :new)
    assert html_response(conn, 200) =~ "New broj"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, broj_path(conn, :create), broj: @valid_attrs
    assert redirected_to(conn) == broj_path(conn, :index)
    assert Repo.get_by(Broj, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, broj_path(conn, :create), broj: @invalid_attrs
    assert html_response(conn, 200) =~ "New broj"
  end

  test "shows chosen resource", %{conn: conn} do
    broj = Repo.insert! %Broj{}
    conn = get conn, broj_path(conn, :show, broj)
    assert html_response(conn, 200) =~ "Show broj"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, broj_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    broj = Repo.insert! %Broj{}
    conn = get conn, broj_path(conn, :edit, broj)
    assert html_response(conn, 200) =~ "Edit broj"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    broj = Repo.insert! %Broj{}
    conn = put conn, broj_path(conn, :update, broj), broj: @valid_attrs
    assert redirected_to(conn) == broj_path(conn, :show, broj)
    assert Repo.get_by(Broj, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    broj = Repo.insert! %Broj{}
    conn = put conn, broj_path(conn, :update, broj), broj: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit broj"
  end

  test "deletes chosen resource", %{conn: conn} do
    broj = Repo.insert! %Broj{}
    conn = delete conn, broj_path(conn, :delete, broj)
    assert redirected_to(conn) == broj_path(conn, :index)
    refute Repo.get(Broj, broj.id)
  end
end

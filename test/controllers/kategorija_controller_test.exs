defmodule Elasr.KategorijaControllerTest do
  use Elasr.ConnCase

  alias Elasr.Kategorija
  @valid_attrs %{naslov: "some content", opis: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, kategorija_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing kategorije"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, kategorija_path(conn, :new)
    assert html_response(conn, 200) =~ "New kategorija"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, kategorija_path(conn, :create), kategorija: @valid_attrs
    assert redirected_to(conn) == kategorija_path(conn, :index)
    assert Repo.get_by(Kategorija, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, kategorija_path(conn, :create), kategorija: @invalid_attrs
    assert html_response(conn, 200) =~ "New kategorija"
  end

  test "shows chosen resource", %{conn: conn} do
    kategorija = Repo.insert! %Kategorija{}
    conn = get conn, kategorija_path(conn, :show, kategorija)
    assert html_response(conn, 200) =~ "Show kategorija"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, kategorija_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    kategorija = Repo.insert! %Kategorija{}
    conn = get conn, kategorija_path(conn, :edit, kategorija)
    assert html_response(conn, 200) =~ "Edit kategorija"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    kategorija = Repo.insert! %Kategorija{}
    conn = put conn, kategorija_path(conn, :update, kategorija), kategorija: @valid_attrs
    assert redirected_to(conn) == kategorija_path(conn, :show, kategorija)
    assert Repo.get_by(Kategorija, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    kategorija = Repo.insert! %Kategorija{}
    conn = put conn, kategorija_path(conn, :update, kategorija), kategorija: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit kategorija"
  end

  test "deletes chosen resource", %{conn: conn} do
    kategorija = Repo.insert! %Kategorija{}
    conn = delete conn, kategorija_path(conn, :delete, kategorija)
    assert redirected_to(conn) == kategorija_path(conn, :index)
    refute Repo.get(Kategorija, kategorija.id)
  end
end

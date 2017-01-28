defmodule Elasr.AutorControllerTest do
  use Elasr.ConnCase

  alias Elasr.Autor
  @valid_attrs %{ime: "some content", opis: "some content", prezime: "some content", spol: true, titula: "some content", zvanje: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, autor_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing autori"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, autor_path(conn, :new)
    assert html_response(conn, 200) =~ "New autor"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, autor_path(conn, :create), autor: @valid_attrs
    assert redirected_to(conn) == autor_path(conn, :index)
    assert Repo.get_by(Autor, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, autor_path(conn, :create), autor: @invalid_attrs
    assert html_response(conn, 200) =~ "New autor"
  end

  test "shows chosen resource", %{conn: conn} do
    autor = Repo.insert! %Autor{}
    conn = get conn, autor_path(conn, :show, autor)
    assert html_response(conn, 200) =~ "Show autor"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, autor_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    autor = Repo.insert! %Autor{}
    conn = get conn, autor_path(conn, :edit, autor)
    assert html_response(conn, 200) =~ "Edit autor"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    autor = Repo.insert! %Autor{}
    conn = put conn, autor_path(conn, :update, autor), autor: @valid_attrs
    assert redirected_to(conn) == autor_path(conn, :show, autor)
    assert Repo.get_by(Autor, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    autor = Repo.insert! %Autor{}
    conn = put conn, autor_path(conn, :update, autor), autor: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit autor"
  end

  test "deletes chosen resource", %{conn: conn} do
    autor = Repo.insert! %Autor{}
    conn = delete conn, autor_path(conn, :delete, autor)
    assert redirected_to(conn) == autor_path(conn, :index)
    refute Repo.get(Autor, autor.id)
  end
end

defmodule Elasr.TekstControllerTest do
  use Elasr.ConnCase

  alias Elasr.Tekst
  @valid_attrs %{fajlovi: "some content", naslov: "some content", slike: "some content", slug: "some content", tekst: "some content", timestamps: "some content", ukratko: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tekst_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tekstovi"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, tekst_path(conn, :new)
    assert html_response(conn, 200) =~ "New tekst"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, tekst_path(conn, :create), tekst: @valid_attrs
    assert redirected_to(conn) == tekst_path(conn, :index)
    assert Repo.get_by(Tekst, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tekst_path(conn, :create), tekst: @invalid_attrs
    assert html_response(conn, 200) =~ "New tekst"
  end

  test "shows chosen resource", %{conn: conn} do
    tekst = Repo.insert! %Tekst{}
    conn = get conn, tekst_path(conn, :show, tekst)
    assert html_response(conn, 200) =~ "Show tekst"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, tekst_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    tekst = Repo.insert! %Tekst{}
    conn = get conn, tekst_path(conn, :edit, tekst)
    assert html_response(conn, 200) =~ "Edit tekst"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tekst = Repo.insert! %Tekst{}
    conn = put conn, tekst_path(conn, :update, tekst), tekst: @valid_attrs
    assert redirected_to(conn) == tekst_path(conn, :show, tekst)
    assert Repo.get_by(Tekst, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tekst = Repo.insert! %Tekst{}
    conn = put conn, tekst_path(conn, :update, tekst), tekst: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit tekst"
  end

  test "deletes chosen resource", %{conn: conn} do
    tekst = Repo.insert! %Tekst{}
    conn = delete conn, tekst_path(conn, :delete, tekst)
    assert redirected_to(conn) == tekst_path(conn, :index)
    refute Repo.get(Tekst, tekst.id)
  end
end

defmodule Elasr.KategorijaController do
  use Elasr.Web, :controller

  alias Elasr.Kategorija

  def index(conn, _params) do
    kategorije = Repo.all(Kategorija)
    render(conn, "index.html", kategorije: kategorije)
  end

  def new(conn, _params) do
    changeset = Kategorija.changeset(%Kategorija{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"kategorija" => kategorija_params}) do
    changeset = Kategorija.changeset(%Kategorija{}, kategorija_params)

    case Repo.insert(changeset) do
      {:ok, _kategorija} ->
        conn
        |> put_flash(:info, "Kategorija created successfully.")
        |> redirect(to: kategorija_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    kategorija = Repo.get!(Kategorija, id)
    render(conn, "show.html", kategorija: kategorija)
  end

  def edit(conn, %{"id" => id}) do
    kategorija = Repo.get!(Kategorija, id)
    changeset = Kategorija.changeset(kategorija)
    render(conn, "edit.html", kategorija: kategorija, changeset: changeset)
  end

  def update(conn, %{"id" => id, "kategorija" => kategorija_params}) do
    kategorija = Repo.get!(Kategorija, id)
    changeset = Kategorija.changeset(kategorija, kategorija_params)

    case Repo.update(changeset) do
      {:ok, kategorija} ->
        conn
        |> put_flash(:info, "Kategorija updated successfully.")
        |> redirect(to: kategorija_path(conn, :show, kategorija))
      {:error, changeset} ->
        render(conn, "edit.html", kategorija: kategorija, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    kategorija = Repo.get!(Kategorija, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(kategorija)

    conn
    |> put_flash(:info, "Kategorija deleted successfully.")
    |> redirect(to: kategorija_path(conn, :index))
  end
end

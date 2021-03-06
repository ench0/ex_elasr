defmodule Elasr.KomentarController do
  use Elasr.Web, :controller

  alias Elasr.Komentar

  def index(conn, _params) do
    komentari = Repo.all(Komentar)
    render(conn, "index.html", komentari: komentari)
  end

  def new(conn, _params) do
    changeset = Komentar.changeset(%Komentar{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"komentar" => komentar_params}) do
    changeset = Komentar.changeset(%Komentar{}, komentar_params)

    case Repo.insert(changeset) do
      {:ok, _komentar} ->
        conn
        |> put_flash(:info, "Komentar created successfully.")
        |> redirect(to: komentar_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    komentar = Repo.get!(Komentar, id)
    render(conn, "show.html", komentar: komentar)
  end

  def edit(conn, %{"id" => id}) do
    komentar = Repo.get!(Komentar, id)
    changeset = Komentar.changeset(komentar)
    render(conn, "edit.html", komentar: komentar, changeset: changeset)
  end

  def update(conn, %{"id" => id, "komentar" => komentar_params}) do
    komentar = Repo.get!(Komentar, id)
    changeset = Komentar.changeset(komentar, komentar_params)

    case Repo.update(changeset) do
      {:ok, komentar} ->
        conn
        |> put_flash(:info, "Komentar updated successfully.")
        |> redirect(to: komentar_path(conn, :show, komentar))
      {:error, changeset} ->
        render(conn, "edit.html", komentar: komentar, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    komentar = Repo.get!(Komentar, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(komentar)

    conn
    |> put_flash(:info, "Komentar deleted successfully.")
    |> redirect(to: komentar_path(conn, :index))
  end
end

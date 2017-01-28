defmodule Elasr.AutorController do
  use Elasr.Web, :controller

  alias Elasr.Autor

  def index(conn, _params) do
    autori = Repo.all(Autor)
    render(conn, "index.html", autori: autori)
  end

  def new(conn, _params) do
    changeset = Autor.changeset(%Autor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"autor" => autor_params}) do
    changeset = Autor.changeset(%Autor{}, autor_params)

    case Repo.insert(changeset) do
      {:ok, _autor} ->
        conn
        |> put_flash(:info, "Autor created successfully.")
        |> redirect(to: autor_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    autor = Repo.get!(Autor, id)
    render(conn, "show.html", autor: autor)
  end

  def edit(conn, %{"id" => id}) do
    autor = Repo.get!(Autor, id)
    changeset = Autor.changeset(autor)
    render(conn, "edit.html", autor: autor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "autor" => autor_params}) do
    autor = Repo.get!(Autor, id)
    changeset = Autor.changeset(autor, autor_params)

    case Repo.update(changeset) do
      {:ok, autor} ->
        conn
        |> put_flash(:info, "Autor updated successfully.")
        |> redirect(to: autor_path(conn, :show, autor))
      {:error, changeset} ->
        render(conn, "edit.html", autor: autor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    autor = Repo.get!(Autor, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(autor)

    conn
    |> put_flash(:info, "Autor deleted successfully.")
    |> redirect(to: autor_path(conn, :index))
  end
end

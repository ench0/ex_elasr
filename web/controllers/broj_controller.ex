defmodule Elasr.BrojController do
  use Elasr.Web, :controller

  alias Elasr.Broj

  def index(conn, _params) do
    brojevi = Repo.all(Broj)
    render(conn, "index.html", brojevi: brojevi)
  end

  def new(conn, _params) do
    changeset = Broj.changeset(%Broj{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"broj" => broj_params}) do
    changeset = Broj.changeset(%Broj{}, broj_params)

    case Repo.insert(changeset) do
      {:ok, _broj} ->
        conn
        |> put_flash(:info, "Broj created successfully.")
        |> redirect(to: broj_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    broj = Repo.get!(Broj, id)
    render(conn, "show.html", broj: broj)
  end

  def edit(conn, %{"id" => id}) do
    broj = Repo.get!(Broj, id)
    changeset = Broj.changeset(broj)
    render(conn, "edit.html", broj: broj, changeset: changeset)
  end

  def update(conn, %{"id" => id, "broj" => broj_params}) do
    broj = Repo.get!(Broj, id)
    changeset = Broj.changeset(broj, broj_params)

    case Repo.update(changeset) do
      {:ok, broj} ->
        conn
        |> put_flash(:info, "Broj updated successfully.")
        |> redirect(to: broj_path(conn, :show, broj))
      {:error, changeset} ->
        render(conn, "edit.html", broj: broj, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    broj = Repo.get!(Broj, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(broj)

    conn
    |> put_flash(:info, "Broj deleted successfully.")
    |> redirect(to: broj_path(conn, :index))
  end
end

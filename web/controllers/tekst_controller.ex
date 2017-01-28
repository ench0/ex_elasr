defmodule Elasr.TekstController do
  use Elasr.Web, :controller

  alias Elasr.Tekst

  def index(conn, _params) do
    tekstovi = Repo.all(Tekst)
    render(conn, "index.html", tekstovi: tekstovi)
  end

  def new(conn, _params) do
    changeset = Tekst.changeset(%Tekst{})
    render(conn, "new.html", changeset: changeset)
  end




  def create(conn, %{"tekst" => tekst_params}) do

    slug = Slugger.slugify(tekst_params["naslov"])
    #slike = %{tekst_params["slike"]}
    #slike = %{:naslov => tekst_params["slike_naslov"], :url => tekst_params["slike_url"]}
    slika1 = %{:slika_naslov_1 => tekst_params["slika_naslov_1"], :slika_url_1 => tekst_params["slika_url_1"] }
    slike = for i <- 2..4 do
      i = Integer.to_string(i)
      atom_naslov = String.to_atom("slika_naslov_"<>i)
      atom_url = String.to_atom("slika_url_"<>i)
      %{atom_naslov => tekst_params["slika_naslov_"<>i], atom_url => tekst_params["slika_url_"<>i]}
    end

    slike = Enum.reduce(slike, slika1, fn(x, acc) -> Map.merge(x,acc) end)
    changeset = Tekst.changeset(%Tekst{}, %{tekst_params | "slug" => slug, "slike" => slike })

    #query = from t in "tekstovi", where: t.slug == ^slug, select: t.slug
    #existing? = Repo.get_by(Tekst, slug: slug)
    #if existing? != nil do
    #  IO.puts "!!!"
    #  conn
    #    |> put_flash(:info, "Tekst uspješno napravljen.")
    #    |> render("new.html", changeset: changeset)
    #end


    query = Repo.get_by(Tekst, slug: slug)
    #if slug == query.slug do
    if query do  
      IO.puts "yyyy"
      conn
        |> put_flash(:error, "Tekst nije uspješno napravljen. Postoji tekst sa istim imenom ili url-om.")
        #|> redirect(to: tekst_params["redirect_to"])
        |> render("new.html", changeset: changeset)
    end

    #IO.puts "+++++naslov+++++"
    #IO.inspect tekst_params["naslov"]
    #IO.puts "+++++cs+++++"
    #IO.inspect changeset
    #IO.puts "+++++params+++++"
    #IO.inspect tekst_params

#    conn
    case Repo.insert(changeset) do
      {:ok, _tekst} ->
        conn
        |> put_flash(:info, "Tekst uspješno napravljen.")
        #|> redirect(to: tekst_params["redirect_to"])
        |> redirect(to: tekst_path(conn, :editname, slug))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end







  def show(conn, %{"slug" => slug}) do
    #tekst = Repo.get!(Tekst, id)
    tekst = Repo.get_by!(Tekst, slug: slug)

    render(conn, "show.html", tekst: tekst)
  end




  def edit(conn, %{"id" => id}) do
    tekst = Repo.get!(Tekst, id)
    changeset = Tekst.changeset(tekst)
    render(conn, "edit.html", tekst: tekst, changeset: changeset)
  end

  def editname(conn, %{"slug" => slug}) do
    tekst = Repo.get_by!(Tekst, slug: slug)
    changeset = Tekst.changeset(tekst)
    render(conn, "edit.html", tekst: tekst, changeset: changeset)
  end






  def update(conn, %{"id" => id, "tekst" => tekst_params}) do

    slika1 = %{:slika_naslov_1 => tekst_params["slika_naslov_1"], :slika_url_1 => tekst_params["slika_url_1"] }
    slike = for i <- 2..4 do
      i = Integer.to_string(i)
      atom_naslov = String.to_atom("slika_naslov_"<>i)
      atom_url = String.to_atom("slika_url_"<>i)
      %{atom_naslov => tekst_params["slika_naslov_"<>i], atom_url => tekst_params["slika_url_"<>i]}
    end

    slike = Enum.reduce(slike, slika1, fn(x, acc) -> Map.merge(x,acc) end)

    tekst = Repo.get!(Tekst, id)
    slug = tekst.slug

    #IO.puts "+++++slike+++++"
    #IO.inspect slike

    #IO.puts "+++++params+++++"
    #IO.inspect tekst_params
    #IO.puts "+++++path+++++"

    changeset = Tekst.changeset(tekst, %{tekst_params | "slike" => slike })

    #IO.puts "+++++cs+++++"
    #IO.inspect changeset
    newslug = tekst_params["slug"]#so it will redirect to new slug if changed

    query = Repo.get_by(Tekst, slug: slug)
    if query do#if found existing slug
      IO.puts "+++++query+++++"
      IO.inspect query.slug
      IO.inspect slug
      IO.inspect newslug
      if newslug != slug do
        conn
          |> put_flash(:error, "Tekst nije uspješno napravljen. Postoji tekst sa istim imenom ili url-om.")
          |> render("edit.html", tekst: tekst, changeset: changeset)
        end
    end

    slug = newslug

    case Repo.update(changeset) do
      {:ok, tekst} ->
        conn
        |> put_flash(:info, "Tekst updated successfully.")
        |> redirect(to: tekst_path(conn, :show, slug))
      {:error, changeset} ->
        render(conn, "edit.html", tekst: tekst, changeset: changeset)
    end
  end




  def delete(conn, %{"id" => id}) do
    tekst = Repo.get!(Tekst, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tekst)

    conn
    |> put_flash(:info, "Tekst deleted successfully.")
    |> redirect(to: tekst_path(conn, :index))
  end

end

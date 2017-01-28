defmodule Elasr.AutorTest do
  use Elasr.ModelCase

  alias Elasr.Autor

  @valid_attrs %{ime: "some content", opis: "some content", prezime: "some content", spol: true, titula: "some content", zvanje: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Autor.changeset(%Autor{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Autor.changeset(%Autor{}, @invalid_attrs)
    refute changeset.valid?
  end
end

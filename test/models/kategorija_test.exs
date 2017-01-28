defmodule Elasr.KategorijaTest do
  use Elasr.ModelCase

  alias Elasr.Kategorija

  @valid_attrs %{naslov: "some content", opis: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Kategorija.changeset(%Kategorija{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Kategorija.changeset(%Kategorija{}, @invalid_attrs)
    refute changeset.valid?
  end
end

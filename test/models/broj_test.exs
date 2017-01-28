defmodule Elasr.BrojTest do
  use Elasr.ModelCase

  alias Elasr.Broj

  @valid_attrs %{fajl: "some content", naslov: "some content", slika: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Broj.changeset(%Broj{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Broj.changeset(%Broj{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule Elasr.TekstTest do
  use Elasr.ModelCase

  alias Elasr.Tekst

  @valid_attrs %{fajlovi: "some content", naslov: "some content", slike: "some content", slug: "some content", tekst: "some content", timestamps: "some content", ukratko: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tekst.changeset(%Tekst{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tekst.changeset(%Tekst{}, @invalid_attrs)
    refute changeset.valid?
  end
end

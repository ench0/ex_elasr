defmodule Elasr.KomentarTest do
  use Elasr.ModelCase

  alias Elasr.Komentar

  @valid_attrs %{email: "some content", komentar: "some content", meta: %{}, timestamps: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Komentar.changeset(%Komentar{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Komentar.changeset(%Komentar{}, @invalid_attrs)
    refute changeset.valid?
  end
end

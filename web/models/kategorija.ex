defmodule Elasr.Kategorija do
  use Elasr.Web, :model

  schema "kategorije" do
    field :naslov, :string
    field :opis, :string

    has_many :tekstovi, Elasr.Tekst

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:naslov, :opis])
    |> cast_assoc(:tekstovi, required: false)
    |> validate_required([:naslov])
    |> validate_length(:naslov, max: 250, message: "Should be less than 250 characters long")
    |> validate_length(:opis, max: 2000, message: "Should be less than 2000 characters long")
  end
end

defmodule Elasr.Broj do
  use Elasr.Web, :model

  schema "brojevi" do
    field :naslov, :string
    field :slika, :string
    field :fajl, :string

    has_many :tekstovi, Elasr.Tekst

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:naslov, :slika, :fajl])
    |> cast_assoc(:tekstovi, required: false)
    |> validate_required([:naslov, :slika, :fajl])
    |> validate_length(:naslov, max: 250, message: "Should be less than 250 characters long")
  end
end

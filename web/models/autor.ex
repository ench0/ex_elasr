defmodule Elasr.Autor do
  use Elasr.Web, :model

  schema "autori" do
    field :ime, :string
    field :prezime, :string
    field :titula, :string
    field :zvanje, :string
    field :spol, :boolean, default: false
    field :opis, :string

    has_many :tekstovi, Elasr.Tekst

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:ime, :prezime, :titula, :zvanje, :spol, :opis])
    |> cast_assoc(:tekstovi, required: false)
    |> validate_required([:ime, :prezime, :spol])
    |> validate_length(:ime, max: 250, message: "Should be less than 250 characters long")
    |> validate_length(:prezime, max: 250, message: "Should be less than 250 characters long")
    |> validate_length(:titula, max: 250, message: "Should be less than 250 characters long")
    |> validate_length(:zvanje, max: 250, message: "Should be less than 250 characters long")
    |> validate_length(:opis, max: 2000, message: "Should be less than 2000 characters long")
  end
end

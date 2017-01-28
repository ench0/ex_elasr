defmodule Elasr.Tekst do
  use Elasr.Web, :model

  schema "tekstovi" do
    field :naslov, :string
    field :ukratko, :string
    field :tekst, :string
    #field :slike, {:array, :string}
    #field :fajlovi, {:array, :string}
    field :slike, :map
    field :fajlovi, :map
    field :slug, :string
    belongs_to :broj, Elasr.Broj
    belongs_to :autor, Elasr.Autor
    belongs_to :kategorija, Elasr.Kategorija
    has_many :komentari, Elasr.Komentar

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:naslov, :ukratko, :tekst, :slike, :fajlovi, :slug])
    |> validate_required([:naslov, :tekst, :slike, :slug], message: "Ne može biti prazno")
    |> validate_length(:naslov, max: 250, message: "Should be less than 250 characters long")
    #|> validate_length(:slike, max: 250, message: "Should be less than 250 characters long")
    #|> validate_length(:fajlovi, max: 250, message: "Should be less than 250 characters long")
    |> validate_length(:slug, max: 250, message: "Should be less than 250 characters long")
    |> validate_length(:ukratko, max: 2000, message: "Should be less than 2000 characters long")
    |> validate_length(:tekst, max: 8000, message: "Should be less than 8000 characters long")
    |> unique_constraint(:naslov, message: "Postoji tekst sa istim imenom")
  end
end

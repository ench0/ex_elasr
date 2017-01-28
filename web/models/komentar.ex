defmodule Elasr.Komentar do
  use Elasr.Web, :model

  schema "komentari" do
    field :komentar, :string
    field :email, :string
    field :meta, :map
    belongs_to :tekst, Elasr.Tekst

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:komentar, :email, :meta, :timestamps])
    |> validate_required([:komentar, :email, :meta, :timestamps])
    |> validate_length(:komentar, max: 2000, message: "Should be less than 2000 characters long")
    |> validate_length(:email, max: 250, message: "Should be less than 250 characters long")
  end
end

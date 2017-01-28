defmodule Elasr.Repo.Migrations.CreateTekst do
  use Ecto.Migration

  def change do
    create table(:tekstovi) do
      add :naslov, :string
      add :ukratko, :string, size: 2048
      add :tekst, :string, size: 8192
      #add :slike, {:array, :string}
      #add :fajlovi, {:array, :string}
      add :slike, :map
      add :fajlovi, :map
      add :slug, :string
      add :autor_id, references(:autori, on_delete: :nothing)
      add :broj_id, references(:brojevi, on_delete: :nothing)
      add :kategorija_id, references(:kategorije, on_delete: :nothing)

      timestamps()
    end
    create index(:tekstovi, [:autor_id])
    create index(:tekstovi, [:kategorija_id])
    create unique_index(:tekstovi, [:naslov])
    create unique_index(:tekstovi, [:slug])
  end
end

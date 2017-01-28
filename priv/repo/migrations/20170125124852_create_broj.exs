defmodule Elasr.Repo.Migrations.CreateBroj do
  use Ecto.Migration

  def change do
    create table(:brojevi) do
      add :naslov, :string
      add :slika, :string
      add :fajl, :string

      timestamps()
    end

  end
end

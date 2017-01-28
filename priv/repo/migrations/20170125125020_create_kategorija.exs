defmodule Elasr.Repo.Migrations.CreateKategorija do
  use Ecto.Migration

  def change do
    create table(:kategorije) do
      add :naslov, :string
      add :opis, :string, size: 2048

      timestamps()
    end

  end
end

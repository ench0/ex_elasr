defmodule Elasr.Repo.Migrations.CreateAutor do
  use Ecto.Migration

  def change do
    create table(:autori) do
      add :ime, :string
      add :prezime, :string
      add :titula, :string
      add :zvanje, :string
      add :spol, :boolean, default: false, null: false
      add :opis, :string, size: 2048

      timestamps()
    end

  end
end

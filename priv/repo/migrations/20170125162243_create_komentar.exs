defmodule Elasr.Repo.Migrations.CreateKomentar do
  use Ecto.Migration

  def change do
    create table(:komentari) do
      add :komentar, :string, size: 2048
      add :email, :string
      add :meta, :map
      add :tekst_id, references(:tekstovi, on_delete: :delete_all)

      timestamps()
    end
    create index(:komentari, [:tekst_id])

  end
end

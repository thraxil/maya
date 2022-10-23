defmodule Maya.Repo.Migrations.AddGalleriesTable do
  use Ecto.Migration

  def change do
    create table(:galleries) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :description, :text
      add :ordinality, :int
      timestamps()
    end
  end
end

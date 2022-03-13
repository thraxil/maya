defmodule Maya.Repo.Migrations.CreateImagesTable do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :title, :string
      add :slug, :string
      add :description, :text
      add :medium, :string
      add :ahash, :string
      add :extension, :string
      timestamps()
    end
  end
end

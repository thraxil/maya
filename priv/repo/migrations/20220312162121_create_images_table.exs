defmodule Maya.Repo.Migrations.CreateImagesTable do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :title, :string
      timestamps()
    end
  end
end

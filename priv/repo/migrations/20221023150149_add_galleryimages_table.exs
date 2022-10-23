defmodule Maya.Repo.Migrations.AddGalleryimagesTable do
  use Ecto.Migration

  def change do
    create table(:galleryimages) do
      add :gallery_id, references(:galleries), null: false
      add :image_id, references(:images), null: false
      add :ordinality, :int
    end

    create index(:galleryimages, [:gallery_id])
    create index(:galleryimages, [:image_id])
  end
end

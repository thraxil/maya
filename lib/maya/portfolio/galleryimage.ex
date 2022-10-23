defmodule Maya.Portfolio.GalleryImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "galleryimages" do
    field :gallery_id, :id
    field :image_id, :id
    field :ordinality, :integer
  end

  @doc false
  def changeset(galleryimage, attrs \\ %{}) do
    galleryimage
    |> cast(attrs, [:gallery_id, :image_id, :ordinality])
    |> validate_required([:gallery_id, :image_id, :ordinality])
  end
end

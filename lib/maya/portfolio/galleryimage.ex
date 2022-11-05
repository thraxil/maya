
defmodule Maya.Portfolio.GalleryImage do
  use Ecto.Schema
  import Ecto.Changeset

  @already_exists "ALREADY_EXISTS"

  schema "galleryimages" do
    belongs_to :gallery, Maya.Portfolio.Gallery, primary_key: true
    belongs_to :image, Maya.Portfolio.Image, primary_key: true
    field :ordinality, :integer
  end

  @doc false
  def changeset(galleryimage, attrs \\ %{}) do
    galleryimage
    |> cast(attrs, [:gallery_id, :image_id, :ordinality])
    |> validate_required([:gallery_id, :image_id, :ordinality])
    |> foreign_key_constraint(:gallery_id)
    |> foreign_key_constraint(:image_id)
    |> unique_constraint([:gallery, :image],
      name: :gallery_id_image_id_unique_index,
      message: @already_exists
    )
  end
end

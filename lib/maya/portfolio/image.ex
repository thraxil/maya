defmodule Maya.Portfolio.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :title, :string
    field :slug, :string
    field :description, :string
    field :medium, :string
    field :ahash, :string
    field :extension, :string

    many_to_many :galleries, Maya.Portfolio.Gallery, join_through: "galleryimages", on_replace: :delete
    timestamps()
  end

  def changeset(image, attrs \\ %{}) do
    image
    |> cast(attrs, [:title, :slug, :description, :medium, :ahash, :extension])
    |> validate_required([:title, :slug, :extension])
  end
end

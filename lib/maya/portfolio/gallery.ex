defmodule Maya.Portfolio.Gallery do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:title]
  @optional_fields [:description]
  
  schema "galleries" do
    field :title, :string, null: false
    field :slug, :string, null: false
    field :description, :string
    field :ordinality, :integer

    many_to_many :images, Maya.Portfolio.Image, join_through: "galleryimages", on_replace: :delete
    
    timestamps()
  end

  def changeset(gallery, attrs \\ %{}) do
    gallery
    |> cast(attrs, @required_fields, @optional_fields)
    |> slugify_title()
    |> validate_required([:title, :slug])
  end

  defp slugify_title(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, slugify(title))
    else
      changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end

  def changeset_update_images(gallery, images) do
    gallery
    |> cast(%{}, @required_fields)
    |> put_assoc(:images, images)
  end
end

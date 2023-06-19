defmodule Maya.Portfolio.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:title, :ahash, :extension]
  @optional_fields [:description, :medium]

  schema "images" do
    field :title, :string
    field :slug, :string
    field :description, :string
    field :medium, :string
    field :ahash, :string
    field :extension, :string

    many_to_many :galleries, Maya.Portfolio.Gallery,
      join_through: "galleryimages",
      on_replace: :delete

    timestamps()
  end

  def changeset(image, attrs \\ %{}) do
    image
    |> cast(attrs, @required_fields, @optional_fields)
    |> slugify_title()
    |> validate_required([:title, :slug, :ahash, :extension])
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
end

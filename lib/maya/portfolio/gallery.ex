defmodule Maya.Portfolio.Gallery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "galleries" do
    field :title, :string, null: false
    field :slug, :string, null: false
    field :description, :string
    field :ordinality, :integer
    timestamps()
  end

  def changeset(gallery, attrs \\ %{}) do
    gallery
    |> cast(attrs, [:title, :slug, :description, :ordinality])
    |> validate_required([:title, :slug, :ordinality])
  end
end

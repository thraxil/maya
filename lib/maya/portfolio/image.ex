defmodule Maya.Portfolio.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :title, :string
    timestamps()
  end

  def changeset(image, attrs \\ %{}) do
    image
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end

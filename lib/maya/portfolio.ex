defmodule Maya.Portfolio do
  import Ecto.Changeset, only: [change: 2]
  import Ecto.Query, warn: false
  alias Maya.Repo

  alias Maya.Portfolio.Image

  def list_images do
    Repo.all(Image)
  end

  def create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end
end

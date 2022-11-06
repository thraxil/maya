defmodule Maya.Portfolio do
  import Ecto.Changeset, only: [change: 2]
  import Ecto.Query, warn: false
  alias Maya.Repo

  alias Maya.Portfolio.Image
  alias Maya.Portfolio.Gallery

  def list_images do
    Repo.all(Image)
  end

  def newest_images(images_per_page, page \\ 1) do
    q = from i in Image,
      order_by: [desc: :inserted_at],
      limit: ^images_per_page,
      offset: ^((page - 1) * images_per_page)
    Repo.all(q)
  end

  def count_images do
    Repo.aggregate(Image, :count, :id)
  end

  def count_galleries do
    Repo.aggregate(Gallery, :count, :id)
  end
  
  def create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end

  def get_image!(id) do
    Repo.get!(Image, id)
  end

  def create_gallery(attrs \\ %{}) do
    %Gallery{}
    |> Gallery.changeset(attrs)
    |> Repo.insert()
  end

  def list_galleries do
    Repo.all(Gallery)
  end

  def get_gallery!(id) do
    Repo.get!(Gallery, id)
  end

  def get_gallery_by_slug!(slug) do
    Repo.get_by!(Gallery, slug: slug)
  end

  def get_image_by_slug!(slug) do
    Repo.get_by!(Image, slug: slug)
  end
end

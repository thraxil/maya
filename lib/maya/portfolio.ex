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

  def _valid_extension(".jpg"), do: ".jpg"
  def _valid_extension(".jpeg"), do: ".jpg"
  def _valid_extension(".png"), do: ".png"
  def _valid_extension(".gif"), do: ".gif"
  def _valid_extension(_), do: ".jpg"

  # expects ahash and extension to be set
  def raw_create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end
  
  def create_image(attrs \\ %{}) do
    upload = attrs["image"]
    extension = _valid_extension(String.downcase(Path.extname(upload.filename)))
    key = Application.fetch_env!(:maya, :reticulum_key)
    url = Application.fetch_env!(:maya, :reticulum_base)

    # send it to reticulum
    form = [{:file, upload.path, {"form-data", [{"name", "image"}, {"filename", "image" <> extension}]}, []}, {"key", key}]
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.post(url, {:multipart, form}, [])
    %{"hash" => hash} = Jason.decode! body

    attrs = Map.put(attrs, "ahash", hash)
    attrs = Map.put(attrs, "extension", extension)

    raw_create_image(attrs)
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

  defp _prev_image(image) do
    q = from i in Image,
      where: i.inserted_at > ^image.inserted_at,
      order_by: [asc: :inserted_at],
      limit: 1
    Repo.one(q)
  end
  
  def prev_image(image) do
    case _prev_image(image) do
      nil -> {false, nil}
      i -> {true, i}
    end
  end
  defp _next_image(image) do
    q = from i in Image,
      where: i.inserted_at < ^image.inserted_at,
      order_by: [desc: :inserted_at],
      limit: 1
    Repo.one(q)
  end
  
  def next_image(image) do
    case _next_image(image) do
      nil -> {false, nil}
      i -> {true, i}
    end
  end
end

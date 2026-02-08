defmodule MayaWeb.PageController do
  alias Maya.Portfolio
  alias Maya.Portfolio.Gallery
  alias Maya.Portfolio.Image

  use MayaWeb, :controller

  def index(conn, _params) do
    images_per_page = Application.fetch_env!(:maya, :images_per_page)
    defaults = %{"page" => "1"}
    params = Map.merge(defaults, conn.query_params)
    {page, _} = Integer.parse(params["page"])
    images_count = Maya.Portfolio.count_images()
    max_page = div(images_count, images_per_page) + 1
    images = Maya.Portfolio.newest_images(images_per_page, min(page, max_page))
    has_next = page * images_per_page <= images_count

    # for preloading
    next_page_images = Maya.Portfolio.newest_images(images_per_page, min(page + 1, max_page))
    prev_page_images = Maya.Portfolio.newest_images(images_per_page, max(page - 1, 1))

    render(conn, "index.html",
      images: images,
      next_page_images: next_page_images,
      prev_page_images: prev_page_images,
      page: min(page, max_page),
      prev_page: max(page - 1, 1),
      has_prev: page > 1,
      next_page: page + 1,
      has_next: has_next
    )
  end

  def show_gallery(conn, %{"slug" => slug}) do
    gallery = Portfolio.get_gallery_by_slug!(slug)
    render(conn, "gallery.html", gallery: gallery)
  end

  def new_gallery(conn, _params) do
    changeset = Gallery.changeset(%Gallery{})
    render(conn, "new_gallery.html", changeset: changeset)
  end

  def create_gallery(conn, %{"gallery" => gallery_params}) do
    case Maya.Portfolio.create_gallery(gallery_params) do
      {:ok, _gallery} ->
        conn
        |> put_flash(:info, "gallery created")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new_gallery.html", changeset: changeset)
    end
  end

  def show_image(conn, %{"slug" => slug}) do
    image = Portfolio.get_image_by_slug!(slug)
    {has_prev, prev_image} = Portfolio.prev_image(image)
    {has_next, next_image} = Portfolio.next_image(image)

    conn
    |> put_resp_header("cache-control", "public, max-age=86400")
    |> render(conn, "image.html",
      page_title: image.title,
      image: image,
      has_prev: has_prev,
      prev_image: prev_image,
      has_next: has_next,
      next_image: next_image
    )
  end

  def new_image(conn, _params) do
    changeset = Image.changeset(%Image{})
    render(conn, "new_image.html", changeset: changeset)
  end

  def create_image(conn, %{"image" => image_params}) do
    case Maya.Portfolio.create_image(image_params) do
      {:ok, _image} ->
        conn
        |> put_flash(:info, "image created")
        |> redirect(to: ~p"/")

      {:error, changeset} ->
        render(conn, "new_image.html", changeset: changeset)
    end
  end
end

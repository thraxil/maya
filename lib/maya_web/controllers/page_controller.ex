defmodule MayaWeb.PageController do
  alias Maya.Portfolio
  alias Maya.Portfolio.Gallery
  alias Maya.Portfolio.Image
  
  use MayaWeb, :controller

  def index(conn, _params) do
    images_count = Maya.Portfolio.count_images()
    galleries_count = Maya.Portfolio.count_galleries()
    galleries = Maya.Portfolio.list_galleries()
    render conn, "index.html",
      galleries: galleries,
      images_count: images_count,
      galleries_count: galleries_count
  end

  def show_gallery(conn, %{"slug" => slug}) do
    gallery = Portfolio.get_gallery_by_slug!(slug)
    render conn, "gallery.html", gallery: gallery
  end

  def new_gallery(conn, _params) do
    changeset = Gallery.changeset(%Gallery{})
    render conn, "new_gallery.html", changeset: changeset
  end

  def create_gallery(conn, %{"gallery" => gallery_params}) do
    case Maya.Portfolio.create_gallery(gallery_params) do
      {:ok, gallery} ->
        conn
        |> put_flash(:info, "gallery created")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, changeset} ->
        render conn, "new_gallery.html", changeset: changeset
    end
  end
end

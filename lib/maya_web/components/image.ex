defmodule MayaWeb.Components.Image do
  use Phoenix.Component
  alias MayaWeb.Router.Helpers, as: Routes
  import Phoenix.HTML.Tag
  alias Maya.Portfolio.Image

  defp image_thumb_url(%Image{ahash: ahash, extension: extension, slug: slug}) do
    "https://d2f33fmhbh7cs9.cloudfront.net/image/" <> ahash <> "/200s/" <> slug <> extension
  end

  attr :height, :integer, default: 200
  attr :width, :integer, default: 200
  attr :image, Image, required: true

  def image(assigns) do
    ~H"""
    <div class="image">
      <.link navigate={Routes.page_path(MayaWeb.Endpoint, :show_image, @image.slug) <> "#img1"}>
        <%= img_tag(image_thumb_url(@image), alt: @image.title, height: @height, width: @width) %>
      </.link>
    </div>
    """
  end
end

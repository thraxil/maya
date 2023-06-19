defmodule MayaWeb.PageView do
  use MayaWeb, :view
  alias Maya.Portfolio.Image

  def image_thumb_url(%Image{ahash: ahash, extension: extension, slug: slug}) do
    "https://d2f33fmhbh7cs9.cloudfront.net/image/" <> ahash <> "/200s/" <> slug <> extension
  end

  def image_large_url(%Image{ahash: ahash, extension: extension, slug: slug}) do
    "https://d2f33fmhbh7cs9.cloudfront.net/image/" <> ahash <> "/960w/" <> slug <> extension
  end
end

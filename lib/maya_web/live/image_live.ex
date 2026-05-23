defmodule MayaWeb.ImageLive do
  use MayaWeb, :live_view
  alias Maya.Portfolio

  def image_large_url(%Portfolio.Image{ahash: ahash, extension: extension, slug: slug}) do
    "https://d2f33fmhbh7cs9.cloudfront.net/image/" <> ahash <> "/960w/" <> slug <> extension
  end

  def mount(%{"slug" => slug}, _session, socket) do
    image = Portfolio.get_image_by_slug!(slug)
    {has_prev, prev_image} = Portfolio.prev_image(image)
    {has_next, next_image} = Portfolio.next_image(image)

    socket =
      assign(socket,
        page_title: image.title,
        image: image,
        has_prev: has_prev,
        prev_image: prev_image,
        has_next: has_next,
        next_image: next_image
      )

    {:ok, socket}
  end

  def handle_params(%{"slug" => slug}, _url, socket) do
    image = Portfolio.get_image_by_slug!(slug)
    {has_prev, prev_image} = Portfolio.prev_image(image)
    {has_next, next_image} = Portfolio.next_image(image)

    socket =
      assign(socket,
        page_title: image.title,
        image: image,
        has_prev: has_prev,
        prev_image: prev_image,
        has_next: has_next,
        next_image: next_image
      )

    {:noreply, socket}
  end

  def handle_event("keyup", %{"key" => "ArrowLeft"}, socket) do
    if socket.assigns.has_prev do
      {:noreply, push_patch(socket, to: "/images/#{socket.assigns.prev_image.slug}")}
    else
      {:noreply, socket}
    end
  end

  def handle_event("keyup", %{"key" => "ArrowRight"}, socket) do
    if socket.assigns.has_next do
      {:noreply, push_patch(socket, to: "/images/#{socket.assigns.next_image.slug}")}
    else
      {:noreply, socket}
    end
  end

  def handle_event("keyup", _params, socket) do
    {:noreply, socket}
  end
end
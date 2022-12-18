defmodule MayaWeb.PageLive do
  alias Maya.Accounts
  alias Maya.Accounts.User
  alias Maya.Portfolio
  alias Maya.Portfolio.Image
  use MayaWeb, :live_view


  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token),
         do: user
  end

  def image_thumb_url(%Image{ahash: ahash, extension: extension, slug: slug}) do
    "https://d2f33fmhbh7cs9.cloudfront.net/image/" <> ahash <> "/200s/" <> slug <> extension
  end

  def image_large_url(%Image{ahash: ahash, extension: extension, slug: slug}) do
    "https://d2f33fmhbh7cs9.cloudfront.net/image/" <> ahash <> "/960w/" <> slug <> extension
  end
  
  def mount(params, session, socket) do
    defaults = %{"page" => "1"}
    params = Map.merge(defaults, params)
    {page, _} = Integer.parse(params["page"])
    current_user = find_current_user(session)

    {:ok, index_page(assign(socket, page: page, current_user: current_user))}
  end

  defp index_page(socket) do
    page = socket.assigns.page
    images_per_page = Application.fetch_env!(:maya, :images_per_page)
    images_count = Maya.Portfolio.count_images()
    max_page = (div images_count, images_per_page) + 1
    images = Maya.Portfolio.newest_images(images_per_page, min(page, max_page))
    has_next = (page * images_per_page) <= images_count

    # for preloading
    next_page_images = Maya.Portfolio.newest_images(images_per_page, min(page + 1, max_page))
    prev_page_images = Maya.Portfolio.newest_images(images_per_page, max(page - 1, 1))
    
    assign(socket,
      images: images,
      next_page_images: next_page_images,
      prev_page_images: prev_page_images,
      images_count: images_count,
      has_next: has_next,
      prev_page: max(page - 1, 1),
      has_prev: page > 1,
      next_page: page + 1,
    )
  end

  def handle_params(params, _uri, socket) do
    defaults = %{"page" => "1"}
    params = Map.merge(defaults, params)
    {page, _} = Integer.parse(params["page"])
    socket = assign(socket, page: page)
    {:noreply, index_page(socket)}
  end

end

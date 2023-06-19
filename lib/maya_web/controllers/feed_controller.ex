defmodule MayaWeb.RssController do
  use MayaWeb, :controller

  alias Maya.Portfolio
  alias Atomex.{Feed, Entry}

  @author "Anders Pearson"
  @email "anders@thraxil.org"
  @base "https://myopica.org/"
  @title "Myopica"

  def index(conn, _params) do
    images = Portfolio.newest_images(20)
    feed = build_feed(images, conn)

    conn
    |> put_resp_content_type("text/xml")
    |> send_resp(200, feed)
  end

  def build_feed(images, conn) do
    Feed.new(@base, DateTime.utc_now(), @title)
    |> Feed.author(@author, email: @email)
    |> Feed.link(Routes.rss_url(conn, :index), rel: "self")
    |> Feed.entries(Enum.map(images, &get_entry(conn, &1)))
    |> Feed.build()
    |> Atomex.generate_document()
  end

  defp get_entry(conn, %{
         title: title,
         slug: slug,
         description: description,
         ahash: ahash,
         extension: extension,
         inserted_at: inserted_at
       }) do
    Entry.new(
      Routes.page_url(conn, :show_image, slug),
      DateTime.from_naive!(inserted_at, "Etc/UTC"),
      title
    )
    |> Entry.link(Routes.page_url(conn, :show_image, slug))
    |> Entry.author(@author)
    |> Entry.content(
      "<img src=\"https://d2f33fmhbh7cs9.cloudfront.net/image/" <>
        ahash <> "/960w/" <> slug <> extension <> "\"/><p>#{description}</p>",
      type: "html"
    )
    |> Entry.build()
  end
end

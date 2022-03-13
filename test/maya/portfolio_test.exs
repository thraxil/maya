defmodule Maya.PortfolioTest do
  use Maya.DataCase

  alias Maya.Portfolio

  describe "images" do
#    alias Maya.Portfolio.Image

    @valid_attrs %{title: "some title", slug: "some-slug", description: "a description", medium: "stuff", ahash: "1234", extension: ".jpg"}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portfolio.create_image()
      image
    end

    test "list_images/0 returns empty list when no images" do
      assert Portfolio.list_images() == []
    end

    test "list_images/0 returns all images" do
      assert Portfolio.list_images() == []
      image = image_fixture()
      assert Portfolio.list_images() == [image]
    end

    test "get_image/1 returns image" do
      image = image_fixture()
      res = Portfolio.get_image!(image.id)
      assert res.title == image.title
      assert res.slug == image.slug
      assert res.description == image.description
      assert res.medium == image.medium
      assert res.ahash == image.ahash
      assert res.extension == image.extension
    end
  end
end

defmodule Maya.PortfolioTest do
  use Maya.DataCase

  alias Maya.Portfolio

  describe "images" do
    #    alias Maya.Portfolio.Image

    @valid_attrs %{
      title: "some title",
      slug: "some-slug",
      description: "a description",
      medium: "stuff",
      ahash: "1234",
      extension: ".jpg"
    }

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portfolio.raw_create_image()

      image
    end

    test "list_images/0 returns empty list when no images" do
      assert Portfolio.list_images() == []
    end

    test "count_images/0 returns 0 when no images" do
      assert Portfolio.count_images() == 0
    end

    test "count_galleries/0 returns 0 when no galleries" do
      assert Portfolio.count_galleries() == 0
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

  describe "galleries" do
    #    alias Maya.Portfolio.Gallery

    @valid_attrs %{
      title: "some title",
      slug: "some-slug",
      description: "a description",
      ordinality: 1
    }

    def gallery_fixture(attrs \\ %{}) do
      {:ok, gallery} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portfolio.create_gallery()

      gallery
    end

    test "list_galleries/0 returns empty list when no galleries" do
      assert Portfolio.list_galleries() == []
    end

    test "list_galleries/0 returns all galleries" do
      assert Portfolio.list_galleries() == []
      gallery = gallery_fixture()
      assert Portfolio.list_galleries() == [gallery]
    end

    test "get_gallery/1 returns gallery" do
      gallery = gallery_fixture()
      res = Portfolio.get_gallery!(gallery.id)
      assert res.title == gallery.title
      assert res.slug == gallery.slug
      assert res.description == gallery.description
      assert res.ordinality == gallery.ordinality
    end
  end
end

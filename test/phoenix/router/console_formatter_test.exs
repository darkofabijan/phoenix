defmodule Phoenix.Router.ConsoleFormatterTest do
  use ExUnit.Case
  alias Phoenix.Router.ConsoleFormatter

  defmodule RouterTestSingleRoutes do
    use Phoenix.Router

    get "/", Phoenix.Controllers.Pages, :index, as: :page
    post "/images", Phoenix.Controllers.Images, :upload, as: :upload_image
    delete "/images", Phoenix.Controllers.Images, :destroy, as: :remove_image
  end

  test "format multiple routes" do
    assert draw(RouterTestSingleRoutes) == ["        page  GET     /        Phoenix.Controllers.Pages#index",
                                            "upload_image  POST    /images  Phoenix.Controllers.Images#upload",
                                            "remove_image  DELETE  /images  Phoenix.Controllers.Images#destroy"]
  end

  defmodule RouterTestResources do
    use Phoenix.Router

    resources "images", Phoenix.Controllers.Images
  end

  test "format resource routes" do
    assert draw(RouterTestResources) == ["    images  GET     images           Phoenix.Controllers.Images#index",
                                         "edit_image  GET     images/:id/edit  Phoenix.Controllers.Images#edit",
                                         "     image  GET     images/:id       Phoenix.Controllers.Images#show",
                                         " new_image  GET     images/new       Phoenix.Controllers.Images#new",
                                         "            POST    images           Phoenix.Controllers.Images#create",
                                         "            PUT     images/:id       Phoenix.Controllers.Images#update",
                                         "            PATCH   images/:id       Phoenix.Controllers.Images#update",
                                         "            DELETE  images/:id       Phoenix.Controllers.Images#destroy"]
  end

  defp draw(router) do
    ConsoleFormatter.format_routes(router.__routes__)
  end
end


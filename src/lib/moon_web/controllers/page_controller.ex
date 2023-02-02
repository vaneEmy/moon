defmodule MoonWeb.PageController do
  use MoonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

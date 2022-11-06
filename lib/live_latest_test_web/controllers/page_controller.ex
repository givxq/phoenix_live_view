defmodule LiveLatestTestWeb.PageController do
  use LiveLatestTestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

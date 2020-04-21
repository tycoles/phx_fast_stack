defmodule PhxFastStackWeb.PageController do
  use PhxFastStackWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

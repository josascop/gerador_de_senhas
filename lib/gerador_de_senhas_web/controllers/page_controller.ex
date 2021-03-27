defmodule GeradorDeSenhasWeb.PageController do
  use GeradorDeSenhasWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

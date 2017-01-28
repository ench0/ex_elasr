defmodule Elasr.PageController do
  use Elasr.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

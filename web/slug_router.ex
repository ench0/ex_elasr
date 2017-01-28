defmodule Elasr.SlugRouter do
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{params: %{"id" => id}} = conn, action) do
    cond do
      Regex.match?(~r/^\d{5}$/, id) ->
        SomeController.call(conn, SomeController.init(action))
      Regex.match?(~r/^A\d{4}$/, id) ->
        OtherController.call(conn, OtherController.init(action))
      true -> conn
    end
  end
end
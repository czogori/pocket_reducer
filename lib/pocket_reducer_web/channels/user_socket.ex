defmodule PocketReducerWeb.UserSocket do
  use Phoenix.Socket
  use Drab.Socket

  transport(:websocket, Phoenix.Transports.WebSocket)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end

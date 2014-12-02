defmodule Philae.WebSocketClient do
  alias Philae.DDP
  @behaviour :websocket_client_handler

  def start_link() do
    start_link("ws://localhost:3000/websocket")
  end

  def start_link(url) do
    {:ok, socket} = :websocket_client.start_link(String.to_char_list(url), __MODULE__, [])
    DDP.connect(socket)
    {:ok, socket}
  end

  def init([], conn_state) do
    {:ok, :websocket_req.get(:socket, conn_state)}
  end

  def websocket_handle({:text, message}, conn_state, socket) do
    IO.puts "In: #{message}"
    DDP.handle(self, message)
    {:ok, socket}
  end

  def websocket_info({:send, msg}, _conn_state, socket) do
    IO.puts "Out: #{msg}"
    {:reply, {:text, msg}, socket}
  end

  def websocket_terminate(_reason, _conn_state, _state) do
    :ok
  end
end

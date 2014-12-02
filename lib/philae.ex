defmodule Philae.WebSocketClient do
  @behaviour :websocket_client_handler

  def start_link() do
    start_link("ws://localhost:3000/websocket", Philae.DDP)
  end

  def start_link(url, module) do
    {:ok, socket} = :websocket_client.start_link(String.to_char_list(url), __MODULE__, [module])
  end

  def init([module], conn_state) do
    {:ok, module}
  end

  def websocket_handle({:text, message}, conn_state, module) do
    IO.puts "In: #{message}"
    apply(module, :handle, [self, message])
    {:ok, module}
  end

  def websocket_info({:send, message}, _conn_state, module) do
    IO.puts "Out: #{message}"
    {:reply, {:text, message}, module}
  end

  def websocket_terminate(_reason, _conn_state, _state) do
    :ok
  end
end

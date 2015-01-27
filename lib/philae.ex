require Logger

defmodule Philae.WebSocketClient do
  @behaviour :websocket_client_handler

  def start_link(url, module, pid) do
    {:ok, _socket} = :websocket_client.start_link(String.to_char_list(url), __MODULE__, [module, pid])
  end

  def init([module, pid], _conn_state) do
    {:ok, {module, pid}}
  end

  def websocket_handle({:text, message}, _conn_state, {module, pid}) do
    apply(module, :handle, [pid, message])
    {:ok, {module, pid}}
  end

  def websocket_info({:send, message}, _conn_state, {module, pid}) do
    Logger.info("Out: #{message}")
    {:reply, {:text, message}, {module, pid}}
  end

  def websocket_terminate(_reason, _conn_state, _state) do
    :ok
  end
end

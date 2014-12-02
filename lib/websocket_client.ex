defmodule WebsocketClient do
  alias Poison, as: JSON

  @doc """
  Starts the WebSocket server for given ws URL. Received Socket.Message's
  are forwarded to the sender pid
  """
  def start_link(sender, url) do
    :crypto.start
    :ssl.start
    :websocket_client.start_link(String.to_char_list(url), __MODULE__, [sender])
  end

  def init([sender], _conn_state) do
    {:ok, sender}
  end

  @doc """
  Receives JSON encoded Socket.Message from remote WS endpoint and
  forwards message to client sender process
  """
  def websocket_handle({:text, msg}, _conn_state, sender) do
    send sender, msg
    {:ok, sender}
  end

  @doc """
  Sends JSON encoded Socket.Message to remote WS endpoint
  """
  def websocket_info({:send, msg}, _conn_state, sender) do
    {:reply, {:text, msg}, sender}
  end

  def websocket_terminate(_reason, _conn_state, _state) do
    :ok
  end

  defp json!(map), do: JSON.encode!(map) |> IO.iodata_to_binary
end

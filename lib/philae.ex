defmodule Philae do
  use HTTPoison.Base
  alias Poison, as: JSON
  @behaviour :websocket_client_handler

  def start_link() do
    start_link("ws://localhost:3000/websocket")
  end

  def start_link(url) do
    {:ok, socket} = :websocket_client.start_link(String.to_char_list(url), __MODULE__, [])
    connect(socket)
    {:ok, socket}
  end

  def init([], conn_state) do
    {:ok, :websocket_req.get(:socket, conn_state)}
  end

  def connect(socket) do
    send socket, {:send, connect_message}
  end

  def websocket_handle({:pong, _}, _ConnState, state) do
    {:ok, state};
  end


  @doc """
  Receives JSON encoded Socket.Message from remote WS endpoint and
  forwards message to client sender process
  """
  def websocket_handle({:text, msg}, conn_state, socket) do
    IO.puts "In: #{msg}"
    {:ok, message} = JSON.decode(msg)
    case message do
      %{"msg" => "ping"} ->
        send_json_message(%{msg: "pong"})
      _ -> IO.puts "I dont know what to do with #{msg}"
    end
    {:ok, socket}
  end

  def send_json_message(map) do
    send(self, {:send, json!(map)})
  end

  @doc """
  Sends JSON encoded Socket.Message to remote WS endpoint
  """
  def websocket_info({:send, msg}, _conn_state, socket) do
    IO.puts "Out: #{msg}"
    {:reply, {:text, msg}, socket}
  end

  def websocket_terminate(_reason, _conn_state, _state) do
    :ok
  end

  defp connect_message do
    json!(%{msg: "connect", version: "1", support: ["1","pre2","pre1"]})
  end

  def json!(map) do
    JSON.encode!(map) |> IO.iodata_to_binary
  end

  #def listen(socket) do
  #  Socket.Web.recv!(socket) |> parse(socket)
  #  listen(socket)
  #end

  #def parse({:close, :normal, ""}, _socket) do
  #  IO.puts "We out"
  #  System.halt(0)
  #end

  #def parse({:text, msg}, socket) do
  #  {:ok, msg} = Poison.decode(msg)
  #  case  msg do
  #    %{"msg" => "ping"} ->
  #      IO.inspect msg
  #      IO.inspect %{"msg" => "pong"}
  #      Socket.Web.send!(socket, {:text, json!(%{msg: "pong"})})
  #    msg -> IO.inspect(msg)
  #  end
  #end

end

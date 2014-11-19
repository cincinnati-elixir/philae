defmodule Philae do
  use HTTPoison.Base

  def start do
    socket = Socket.Web.connect!("localhost", 3000, scheme: "ws", path: "/websocket")
  end

  def connect(socket) do
    Socket.Web.send!(socket, {:text, connect_message})
  end

  def listen(socket) do
    Socket.Web.recv!(socket) |> parse(socket)
    listen(socket)
  end

  def parse({:close, :normal, ""}, _socket) do
    IO.puts "We out"
    System.halt(0)
  end

  def parse({:text, msg}, socket) do
    {:ok, msg} = Poison.decode(msg)
    case  msg do
      %{"msg" => "ping"} ->
        IO.inspect msg
        IO.inspect %{"msg" => "pong"}
        Socket.Web.send!(socket, {:text, json!(%{msg: "pong"})})
      msg -> IO.inspect(msg)
    end
  end

  defp connect_message do
    json!(%{msg: "connect", version: "1", support: ["1","pre2","pre1"]})
  end

  def json!(map) do
    Poison.encode!(map) |> IO.iodata_to_binary
  end
end

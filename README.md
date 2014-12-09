Philae
======

Land a Elixir app onto a MeteorJs App

Connect to a Meteor app and subscribe to collections

There is still some wierdness in the DDP module w/ the Client API but
for now you can implement a simple client like so

```elixir
defmodule PlayerVoter do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], [])
  end

  def init([]) do
    {:ok, client_pid } = Philae.DDP.connect("ws://localhost:3000/websocket", __MODULE__)
    {collection, id} = Philae.DDP.subscribe(client_pid, "players")
    {:ok, %{client_pid: client_pid, subscription_id: id, collection: collection}}
  end

  def added(pid, message) do
    GenServer.call(pid, {:added, message})
  end

  def handle_call({:added, message}, _from, state) do
    IO.puts "We got here and got"
    IO.inspect message
    {:reply, :ok, state}
  end
end
```

An Example of calling PlayerVoter from IEx

```elixir
iex(1)> PlayerVoter.start_link
In: {"server_id":"0"}
I dont know what to with
%{"server_id" => "0"}
Out: {"version":"1","support":["1","pre2","pre1"],"msg":"connect"}
In: {"msg":"connected","session":"5StuZbjGzfaQ8wADT"}
I dont know what to with
%{"msg" => "connected", "session" => "5StuZbjGzfaQ8wADT"}
{:ok, #PID<0.169.0>}
Out: {"name":"players","msg":"sub","id":"17703351-03a6-4e0b-ae03-509ce5ede83f"}
In: {"msg":"added","collection":"players","id":"EDwgtEt6weAn7hXXa","fields":{"name":"Ada Lovelace","score":55}}
We got here and got
%{"collection" => "players",
  "fields" => %{"name" => "Ada Lovelace", "score" => 55},
  "id" => "EDwgtEt6weAn7hXXa", "msg" => "added"}
In: {"msg":"added","collection":"players","id":"4J7BzXDpupHHFyhC8","fields":{"name":"Grace Hopper","score":75}}
We got here and got
%{"collection" => "players",
  "fields" => %{"name" => "Grace Hopper", "score" => 75},
  "id" => "4J7BzXDpupHHFyhC8", "msg" => "added"}
In: {"msg":"added","collection":"players","id":"jbeTgrLuctE5tFjKd","fields":{"name":"Marie Curie","score":40}}
We got here and got
%{"collection" => "players",
  "fields" => %{"name" => "Marie Curie", "score" => 40},
  "id" => "jbeTgrLuctE5tFjKd", "msg" => "added"}
In: {"msg":"added","collection":"players","id":"S8kC3ze7T8DpxLdM3","fields":{"name":"Carl Friedrich Gauss","score":60}}
We got here and got
%{"collection" => "players",
  "fields" => %{"name" => "Carl Friedrich Gauss", "score" => 60},
  "id" => "S8kC3ze7T8DpxLdM3", "msg" => "added"}
In: {"msg":"added","collection":"players","id":"AC96Gf6YhaWt74dTR","fields":{"name":"Nikola Tesla","score":65}}
We got here and got
%{"collection" => "players",
  "fields" => %{"name" => "Nikola Tesla", "score" => 65},
  "id" => "AC96Gf6YhaWt74dTR", "msg" => "added"}
In: {"msg":"added","collection":"players","id":"Ya2LCwnNyFxWraDfD","fields":{"name":"Claude Shannon","score":25}}
We got here and got
%{"collection" => "players",
  "fields" => %{"name" => "Claude Shannon", "score" => 25},
  "id" => "Ya2LCwnNyFxWraDfD", "msg" => "added"}
In: {"msg":"ready","subs":["17703351-03a6-4e0b-ae03-509ce5ede83f"]}
I dont know what to with
%{"msg" => "ready", "subs" => ["17703351-03a6-4e0b-ae03-509ce5ede83f"]}
In: {"msg":"ping"}
Out: {"msg":"pong"}
iex(2)>
```


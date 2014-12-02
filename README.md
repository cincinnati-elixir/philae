Philae
======

Land a Elixir app onto a MeteorJs App

Connect to a Meteor app and subscribe to collections

```elixir

iex(1)>  {:ok, pid} = Philae.DDP.connect("ws://localhost:3000/websocket")
In: {"server_id":"0"}
I dont know what to with
%{"server_id" => "0"}

Out: {"version":"1","support":["1","pre2","pre1"],"msg":"connect"}
In: {"msg":"connected","session":"EsBEM8CxK8AEBgEKR"}

I dont know what to with
%{"msg" => "connected", "session" => "EsBEM8CxK8AEBgEKR"}
{:ok, #PID<0.139.0>}

iex(2)> Philae.DDP.subscribe(pid, "players", self)

Out: {"name":"players","msg":"sub","id":"2b0ec2aa-0ce0-4570-ae14-3b0797b54074"}

{:send,
 "{\"name\":\"players\",\"msg\":\"sub\",\"id\":\"2b0ec2aa-0ce0-4570-ae14-3b0797b54074\"}"}
In: {"msg":"added","collection":"players","id":"EDwgtEt6weAn7hXXa","fields":{"name":"Ada Lovelace","score":55}}

Got an Add message to collection players
The message was
%{"collection" => "players",
  "fields" => %{"name" => "Ada Lovelace", "score" => 55},
  "id" => "EDwgtEt6weAn7hXXa", "msg" => "added"}

In: {"msg":"added","collection":"players","id":"4J7BzXDpupHHFyhC8","fields":{"name":"Grace Hopper","score":70}}
Got an Add message to collection players
The message was
%{"collection" => "players",
  "fields" => %{"name" => "Grace Hopper", "score" => 70},
  "id" => "4J7BzXDpupHHFyhC8", "msg" => "added"}

In: {"msg":"added","collection":"players","id":"jbeTgrLuctE5tFjKd","fields":{"name":"Marie Curie","score":40}}
Got an Add message to collection players
The message was
%{"collection" => "players",
  "fields" => %{"name" => "Marie Curie", "score" => 40},
  "id" => "jbeTgrLuctE5tFjKd", "msg" => "added"}

In: {"msg":"added","collection":"players","id":"S8kC3ze7T8DpxLdM3","fields":{"name":"Carl Friedrich Gauss","score":60}}
Got an Add message to collection players
The message was
%{"collection" => "players",
  "fields" => %{"name" => "Carl Friedrich Gauss", "score" => 60},
  "id" => "S8kC3ze7T8DpxLdM3", "msg" => "added"}

In: {"msg":"added","collection":"players","id":"AC96Gf6YhaWt74dTR","fields":{"name":"Nikola Tesla","score":65}}
Got an Add message to collection players
The message was
%{"collection" => "players",
  "fields" => %{"name" => "Nikola Tesla", "score" => 65},
  "id" => "AC96Gf6YhaWt74dTR", "msg" => "added"}

In: {"msg":"added","collection":"players","id":"Ya2LCwnNyFxWraDfD","fields":{"name":"Claude Shannon","score":25}}
Got an Add message to collection players
The message was
%{"collection" => "players",
  "fields" => %{"name" => "Claude Shannon", "score" => 25},
  "id" => "Ya2LCwnNyFxWraDfD", "msg" => "added"}

In: {"msg":"ready","subs":["2b0ec2aa-0ce0-4570-ae14-3b0797b54074"]}
I dont know what to with
%{"msg" => "ready", "subs" => ["2b0ec2aa-0ce0-4570-ae14-3b0797b54074"]}

In: {"msg":"ping"}
Out: {"msg":"pong"}
```



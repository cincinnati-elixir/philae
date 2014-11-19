defmodule PhilaeTest do
  use ExUnit.Case

  test "the truth" do
    Philae.start
    assert Philae.start_link == {:ok, ""}
  end
end

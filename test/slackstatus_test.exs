defmodule SlackstatusTest do
  use ExUnit.Case
  doctest Slackstatus

  test "greets the world" do
    assert Slackstatus.hello() == :world
  end
end

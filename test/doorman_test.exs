defmodule DoormanTest do
  use ExUnit.Case
  doctest Doorman

  test "greets the world" do
    assert Doorman.hello() == :world
  end
end

defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case
  alias IslandsEngine.{Coordinate, Guesses}

  describe "new/2" do
    test "should be able to add guesses into the hits" do
      guesses = Guesses.new()
      {:ok, coordinate1} = Coordinate.new(1, 1)
      {:ok, coordinate2} = Coordinate.new(2, 2)

      guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate1))
      guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate2))

      assert MapSet.size(guesses.hits) == 2
      assert coordinate1 in guesses.hits
      assert coordinate2 in guesses.hits
    end
  end
end

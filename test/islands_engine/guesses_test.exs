defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case
  alias IslandsEngine.{Coordinate, Guesses}

  describe "new/2" do
    test "should be able to initalize guesses" do
      assert %Guesses{} = Guesses.new()
      # {:ok, coordinate1} = Coordinate.new(1, 1)
      # {:ok, coordinate2} = Coordinate.new(2, 2)

      # guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate1))
      # guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate2))

      # assert MapSet.size(guesses.hits) == 2
      # assert coordinate1 in guesses.hits
      # assert coordinate2 in guesses.hits
    end
  end

  describe "add/3" do
    test "should be able to add guesses to hits" do
      guesses = Guesses.new()
      {:ok, coordinate1} = Coordinate.new(8, 3)
      {:ok, coordinate2} = Coordinate.new(9, 7)

      guesses = Guesses.add(guesses, :hit, coordinate1)
      guesses = Guesses.add(guesses, :hit, coordinate2)

      assert %Guesses{} = guesses
      assert MapSet.size(guesses.hits) == 2
      assert coordinate1 in guesses.hits
      assert coordinate2 in guesses.hits
    end

    test "should be able to add guesses to misses" do
      guesses = Guesses.new()
      {:ok, coordinate1} = Coordinate.new(8, 3)
      {:ok, coordinate2} = Coordinate.new(9, 7)

      guesses = Guesses.add(guesses, :miss, coordinate1)
      guesses = Guesses.add(guesses, :miss, coordinate2)

      assert %Guesses{} = guesses
      assert MapSet.size(guesses.misses) == 2
      assert coordinate1 in guesses.misses
      assert coordinate2 in guesses.misses
    end
  end
end

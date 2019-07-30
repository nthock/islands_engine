defmodule IslandsEngine.IslandTest do
  use ExUnit.Case
  alias IslandsEngine.{Coordinate, Island}

  describe "new/2" do
    test "building an L-shape island" do
      {:ok, coordinate} = Coordinate.new(4, 6)
      assert {:ok, island} = Island.new(:l_shape, coordinate)
      assert MapSet.size(island.coordinates) == 4
    end

    test "should return error when passed in invalid island key" do
      {:ok, coordinate} = Coordinate.new(4, 6)
      assert {:error, :invalid_island_type} = Island.new(:wrong, coordinate)
    end

    test "should return error for invalid coordinate" do
      {:ok, coordinate} = Coordinate.new(10, 10)
      assert {:error, :invalid_coordinate} = Island.new(:l_shape, coordinate)
    end
  end
end

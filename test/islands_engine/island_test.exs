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

  describe "overlap?/2" do
    test "square and dot island should overlap" do
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)
      {:ok, dot_coordinate} = Coordinate.new(1, 2)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      assert Island.overlap?(square, dot)
    end

    test "square and l_shape should not overlap" do
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)
      {:ok, l_shape_coordinate} = Coordinate.new(5, 5)
      {:ok, l_shape} = Island.new(:l_shape, l_shape_coordinate)

      refute Island.overlap?(square, l_shape)
    end

    test "dot and l_shape should not overlap" do
      {:ok, dot_coordinate} = Coordinate.new(1, 2)
      {:ok, dot} = Island.new(:dot, dot_coordinate)
      {:ok, l_shape_coordinate} = Coordinate.new(5, 5)
      {:ok, l_shape} = Island.new(:l_shape, l_shape_coordinate)

      refute Island.overlap?(dot, l_shape)
    end
  end
end

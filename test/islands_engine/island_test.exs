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

  describe "overlaps?/2" do
    test "square and dot island should overlap" do
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)
      {:ok, dot_coordinate} = Coordinate.new(1, 2)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      assert Island.overlaps?(square, dot)
    end

    test "square and l_shape should not overlap" do
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)
      {:ok, l_shape_coordinate} = Coordinate.new(5, 5)
      {:ok, l_shape} = Island.new(:l_shape, l_shape_coordinate)

      refute Island.overlaps?(square, l_shape)
    end

    test "dot and l_shape should not overlap" do
      {:ok, dot_coordinate} = Coordinate.new(1, 2)
      {:ok, dot} = Island.new(:dot, dot_coordinate)
      {:ok, l_shape_coordinate} = Coordinate.new(5, 5)
      {:ok, l_shape} = Island.new(:l_shape, l_shape_coordinate)

      refute Island.overlaps?(dot, l_shape)
    end
  end

  describe "guess/2" do
    test "should return the island if correctly guess the coordinate" do
      {:ok, dot_coordinate} = Coordinate.new(4, 4)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      {:ok, new_coordinate} = Coordinate.new(4, 4)
      assert {:hit, result} = Island.guess(dot, new_coordinate)
      assert new_coordinate in result.hit_coordinates
    end

    test "should return miss if incorrectly guess the coordinate" do
      {:ok, dot_coordinate} = Coordinate.new(4, 4)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      {:ok, new_coordinate} = Coordinate.new(2, 2)
      assert :miss = Island.guess(dot, new_coordinate)
    end
  end

  describe "forested?/1" do
    test "should return true if the island is forested" do
      {:ok, dot_coordinate} = Coordinate.new(4, 4)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      {:ok, new_coordinate} = Coordinate.new(4, 4)
      {:hit, result} = Island.guess(dot, new_coordinate)

      assert Island.forested?(result)
    end

    test "should return false if the island is not forested?" do
      {:ok, dot_coordinate} = Coordinate.new(4, 4)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      refute Island.forested?(dot)
    end
  end
end

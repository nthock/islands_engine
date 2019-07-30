defmodule IslandsEngine.CoordinateTest do
  use ExUnit.Case
  alias IslandsEngine.Coordinate

  describe "new/2" do
    test "should return the coordinate struct when input the correct value" do
      assert {:ok, %Coordinate{}} = Coordinate.new(1, 1)
    end

    test "should return error if the coordinate is not in range" do
      assert {:error, :invalid_coordinate} = Coordinate.new(-1, 1)
      assert {:error, :invalid_coordinate} = Coordinate.new(11, 1)
    end
  end
end

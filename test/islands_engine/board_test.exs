defmodule IslandsEngine.BoardTest do
  use ExUnit.Case
  alias IslandsEngine.{Board, Coordinate, Island}

  describe "position_island/2" do
    test "should return the board with the island when there is no overlapping with existing island on the board" do
      board = Board.new()
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)
      board = Board.position_island(board, :square, square)
      assert board[:square] == square
    end

    test "should return error if the island overlap with existing islands on the board" do
      board = Board.new()
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)
      board = Board.position_island(board, :square, square)

      {:ok, dot_coordinate} = Coordinate.new(2, 2)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      assert {:error, :overlapping_island} = Board.position_island(board, :dot, dot)
    end
  end

  describe "guess/2" do
    setup do
      board = Board.new()
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)
      board = Board.position_island(board, :square, square)

      {:ok, new_dot_coordinate} = Coordinate.new(3, 3)
      {:ok, dot} = Island.new(:dot, new_dot_coordinate)
      board = Board.position_island(board, :dot, dot)

      {:ok, %{board: board, square: square}}
    end

    test "should return the miss and the board if the guess is a miss", %{board: board} do
      {:ok, guess_coordinate} = Coordinate.new(10, 10)
      assert {:miss, :none, :no_win, board} = Board.guess(board, guess_coordinate)
    end

    test "should return hit, but no win is the guess doesn't forest an island or win", %{
      board: board
    } do
      {:ok, hit_coordinate} = Coordinate.new(1, 1)
      assert {:hit, :none, :no_win, board} = Board.guess(board, hit_coordinate)
    end

    test "should return win if all islands coordinates are guessed", %{
      board: board,
      square: square
    } do
      square = %{square | hit_coordinates: square.coordinates}
      board = Board.position_island(board, :square, square)

      {:ok, win_coordinate} = Coordinate.new(3, 3)
      assert {:hit, :dot, :win, board} = Board.guess(board, win_coordinate)
    end
  end
end

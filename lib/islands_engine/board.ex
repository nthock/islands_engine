defmodule IslandsEngine.Board do
  alias IslandsEngine.{Coordinate, Island}

  @type t :: map()

  @spec new :: t()
  def new(), do: %{}

  @spec position_island(t(), atom, Island.t()) :: {:error, :overlapping_island} | t()
  def position_island(board, key, %Island{} = island) do
    case overlaps_existing_island?(board, key, island) do
      true -> {:error, :overlapping_island}
      false -> Map.put(board, key, island)
    end
  end

  @spec all_islands_positioned?(t()) :: boolean
  def all_islands_positioned?(board) do
    Enum.all?(Island.types(), &Map.has_key?(board, &1))
  end

  @spec guess(t(), Coordinate.t()) :: {:hit, atom, :no_win | :win, t()}
  def guess(board, %Coordinate{} = coordinate) do
    board
    |> check_all_islands(coordinate)
    |> guess_response(board)
  end

  @spec overlaps_existing_island?(t(), atom, Island.t()) :: boolean
  defp overlaps_existing_island?(board, new_key, new_island) do
    Enum.any?(board, fn {key, island} ->
      key != new_key and Island.overlaps?(island, new_island)
    end)
  end

  @spec check_all_islands(t(), Coordinate.t()) :: {atom, Island.t()} | :miss
  defp check_all_islands(board, coordinate) do
    Enum.find_value(board, :miss, fn {key, island} ->
      case Island.guess(island, coordinate) do
        {:hit, island} -> {key, island}
        :miss -> false
      end
    end)
  end

  @spec guess_response({atom, Island.t()} | :miss, t()) :: {atom(), atom(), atom(), t()}
  defp guess_response({key, island}, board) do
    board = %{board | key => island}
    {:hit, forest_check(board, key), win_check(board), board}
  end

  defp guess_response(:miss, board) do
    {:miss, :none, :no_win, board}
  end

  @spec forest_check(t(), atom) :: atom
  defp forest_check(board, key) do
    case forested?(board, key) do
      true -> key
      false -> :none
    end
  end

  @spec forested?(t(), atom) :: boolean
  defp forested?(board, key) do
    board
    |> Map.fetch!(key)
    |> Island.forested?()
  end

  @spec win_check(t()) :: :win | :no_win
  defp win_check(board) do
    case all_forested?(board) do
      true -> :win
      false -> :no_win
    end
  end

  @spec all_forested?(t()) :: boolean
  defp all_forested?(board) do
    Enum.all?(board, fn {_key, island} ->
      Island.forested?(island)
    end)
  end
end

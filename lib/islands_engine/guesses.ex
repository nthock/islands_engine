defmodule IslandsEngine.Guesses do
  alias __MODULE__

  @enforce_keys [:hits, :misses]
  defstruct [:hits, :misses]

  @type t :: %Guesses{
    hits: MapSet.t(),
    misses: MapSet.t()
  }

  @spec new() :: t()
  def new do
    %Guesses{hits: MapSet.new(), misses: MapSet.new()}
  end
end

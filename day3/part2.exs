defmodule Rucksack do
  def common_character(rucksack) do
    [ first, second, third ] = rucksack
    first_list = String.to_charlist(first)
    second_list = String.to_charlist(second)
    third_list = String.to_charlist(third)
    results =  filter_commons(first_list, second_list)
    filter_commons(results, third_list) |> List.first
  end

  def priority(char) do
    cond do
      char >= ?a && char <= ?z -> char - 96
      true -> char - 38
    end
  end

  defp filter_commons(first, second) do
    Enum.filter(first, &Enum.member?(second, &1))
  end
end

{:ok, data} = File.read("input.txt")

result = data
  |> String.split(~r/\n|\r\n/)
  |> Enum.chunk_every(3)
  |> Enum.map(&Rucksack.common_character/1)
  |> Enum.map(&Rucksack.priority/1)
  |> Enum.sum

IO.inspect(result)

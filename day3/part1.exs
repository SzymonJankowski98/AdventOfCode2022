defmodule Rucksack do
  def divide(rucksack) do
    length = String.length(rucksack)
    String.split_at(rucksack, div(length, 2))
  end

  def common_character(rucksack) do
    { first, second } = rucksack
    first_list = String.to_charlist(first)
    second_list = String.to_charlist(second)
    Enum.filter(first_list, &Enum.member?(second_list, &1)) |> List.first
  end

  def priority(char) do
    cond do
      char >= ?a && char <= ?z -> char - 96
      true -> char - 38
    end
  end
end

{:ok, data} = File.read("input.txt")

result = data
  |> String.split(~r/\n|\r\n/)
  |> Enum.map(&Rucksack.divide/1)
  |> Enum.map(&Rucksack.common_character/1)
  |> Enum.map(&Rucksack.priority/1)
  |> Enum.sum

IO.inspect(result)

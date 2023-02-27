defmodule Stacks do
  def make_move(stacks, move) do
    from = String.to_integer(Map.get(move, "from")) - 1
    to = String.to_integer(Map.get(move, "to")) - 1
    times = String.to_integer(Map.get(move, "times"))

    taken_crates =
      stacks
      |> Enum.at(from)
      |> Enum.take(times)
      |> Enum.reverse

    destination_stack = taken_crates ++ Enum.at(stacks, to)
    source_stack = stacks |> Enum.at(from) |> Enum.drop(times)

    stacks
      |> List.replace_at(from, source_stack)
      |> List.replace_at(to, destination_stack)
  end

  def parse_move_row(row) do
    Regex.named_captures(~r/move (?<times>.+) from (?<from>.?) to (?<to>.?)/, row)
  end

  def parse_stack_row(row) do
    for i <- 0..8 do
      String.at(row, 4 * i + 1)
    end
  end

  def convert_column(col) do
    col |> Enum.reject(&(&1 == " "))
  end

end

{:ok, data} = File.read("input.txt")

[stack_data, moves_data] = String.split(data, ~r/\n\n|\r\n\r\n/)

moves =
  String.split(moves_data, ~r/\n|\r\n/)
  |> Enum.map(&Stacks.parse_move_row/1)

stacks =
  String.split(stack_data, ~r/\n|\r\n/)
  |> List.delete_at(-1)
  |> Enum.map(&Stacks.parse_stack_row/1)
  |> Enum.zip_with(& &1)
  |> Enum.map(&Stacks.convert_column/1)

result = Enum.reduce(moves, stacks, fn(move, stacks) -> Stacks.make_move(stacks, move) end)

IO.inspect(result)

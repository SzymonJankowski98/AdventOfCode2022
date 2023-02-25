{:ok, data} = File.read("input.txt")

defmodule Assignments do
  def parse(line) do
    String.split(line, ",")
      |> Enum.map(&String.split(&1, "-"))
  end

  def fully_contains?(parsed_line) do
    [[a1_start, a1_end], [a2_start, a2_end]] = parsed_line

    a1_start = String.to_integer(a1_start)
    a1_end = String.to_integer(a1_end)
    a2_start = String.to_integer(a2_start)
    a2_end = String.to_integer(a2_end)

    (a1_start <= a2_start && a1_end >= a2_end) ||
    (a1_start >= a2_start && a1_start <= a2_end) ||
    (a1_end >= a2_start && a1_end <= a2_end)
  end
end

result = data
  |> String.split(~r/\n|\r\n/)
  |> Enum.map(&Assignments.parse/1)
  |> Enum.map(&Assignments.fully_contains?/1)
  |> Enum.count(&(&1))

IO.inspect(result)

defmodule Calories do
  def calculate(lines) do
    lines
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce(0, &+/2)
  end
end

{:ok, data} = File.read("input.txt")

result = data
  |> String.split(~r/\n\n|\r\n\r\n/)
  |> Enum.map(&String.split/1)
  |> Enum.map(&Calories.calculate/1)
  |> Enum.max

IO.inspect(result)

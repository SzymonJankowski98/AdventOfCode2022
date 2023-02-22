{:ok, data} = File.read("input.txt")

defmodule Game do
  def play_round(line) do
    [opponent_shape, your_shape] = line
    score_for_shape(your_shape)
    round_result(opponent_shape, your_shape) + score_for_shape(your_shape)
  end

  defp round_result(opponent_shape, your_shape) do
    case [opponent_shape, your_shape] do
      ["A", "Z"] -> 0
      ["B", "X"] -> 0
      ["C", "Y"] -> 0
      ["A", "X"] -> 3
      ["B", "Y"] -> 3
      ["C", "Z"] -> 3
      ["A", "Y"] -> 6
      ["B", "Z"] -> 6
      ["C", "X"] -> 6
    end
  end

  defp score_for_shape(shape) do
    case shape do
      "X" -> 1
      "Y" -> 2
      "Z" -> 3
    end
  end
end

result = data
  |> String.split(~r/\n|\r\n/)
  |> Enum.map(&String.split/1)
  |> Enum.map(&Game.play_round/1)
  |> Enum.sum

IO.inspect(result)

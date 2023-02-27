{:ok, data} = File.read("input.txt")

result = data
  |> String.to_charlist
  |> Enum.chunk_every(4, 1)
  |> Enum.map(&Enum.uniq/1)
  |> Enum.map(&length/1)
  |> Enum.find_index(&(&1 == 4))

IO.inspect(result + 4)

defmodule Vindinium.Utils do

  @doc """
  Printing the current game tiles to stdout from `state`.
  """
  def print_map(%{"game" => %{"board" => %{"size" => size, "tiles" => tiles}}}) do
    IO.puts("")
    IO.puts("+" <> String.duplicate("-", size*2) <> "+")
    tiles
    |> String.to_charlist
    |> Enum.chunk(size*2)
    |> Enum.each(fn(line) -> IO.puts("|#{line}|") end)
    IO.puts("+" <> String.duplicate("-", size*2) <> "+")
  end

  @doc """
  Making a hero stats line from `state`.
  """
  def print_hero_stats_line(%{"hero" => %{"crashed" => crashed, "elo" => elo, "gold" => gold, "id" => id,
                          "life" => life, "mineCount" => mines, "name" => name,
                          "pos" => _, "spawnPos" => _, "userId" => _}}) do
    IO.puts "#{name} (@#{id}): #{life}/100 mines:#{mines} gold:#{gold} elo:#{elo} crashed:#{inspect crashed}"
  end

end
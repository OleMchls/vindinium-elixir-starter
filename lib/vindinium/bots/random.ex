defmodule Vindinium.Bots.Random do

  alias Vindinium.Utils

  def move(state) do

    # Printing Map and Hero state.
    Utils.print_map(state)
    Utils.print_hero_stats_line(state)

    # Random movement.
    ["Stay", "North", "South", "East", "West"]
    |> Enum.take_random(1)
    |> List.first
  end

end

defmodule Vindium.Bots.Random do

  def move(state) do
    Enum.take_random(["Stay", "North", "South", "East", "West"], 1) |> List.first 
  end

end

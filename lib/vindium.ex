defmodule Vindium do

  def start(secret, mode, turns, bot \\ Vindium.Bots.Random) do
    Vindium.Client.start
    state = start_game(secret, mode, turns)
    IO.puts "Watch game at: #{state["viewUrl"]}"
    move(state, secret, bot)
  end

  def start_game(secret, :training, turns) when is_integer(turns) do
    Vindium.Client.post!("http://vindinium.org/api/training", {:form, [{:key, secret}, {:turns, turns}]}).body
  end

  def start_game(secret, :arena, _turns) do
    Vindium.Client.post!("http://vindinium.org/api/arena", {:form, [{:key, secret}]}, [timeout: 10000]).body
  end

  def move(%{"game" => %{"finished" => true}} = state, _secret, _bot) do

    msg = case find_leader(state["game"]["heroes"]) do
      %{"name" => winner} ->
        IO.puts "#{winner} won!"
      :draw ->
        IO.puts "DRAW! No winner :("
    end

    IO.puts "\nGame ended – #{msg}"
  end

  def move(state, secret, bot) do
    IO.write(".")
    Vindium.Client.post!(state["playUrl"], {:form, [{:key, secret}, {:dir, bot.move(state)}]}).body
    |> move(secret, bot)
  end

  defp find_leader(heroes) do
    leader = Enum.max_by(heroes, fn(%{"gold" => gold}) -> gold end)

    case Enum.filter(heroes, fn(%{"gold" => gold}) -> gold == leader["gold"] end) do
      filtered_heroes when length(filtered_heroes) > 1 ->
        :draw
      _ ->
        leader
    end
  end

end

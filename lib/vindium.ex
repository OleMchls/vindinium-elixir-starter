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
    %{"name" => winnder} = find_leader(state["game"]["heroes"])
    IO.puts "\nGame ended – #{winnder} won!"
  end

  def move(state, secret, bot) do
    IO.write(".")
    Vindium.Client.post!(state["playUrl"], {:form, [{:key, secret}, {:dir, bot.move(state)}]}).body
    |> move(secret, bot)
  end

  defp find_leader(heros) do
    Enum.max_by(heros, fn(%{"gold" => gold}) -> gold end)
  end

end

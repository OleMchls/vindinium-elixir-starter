defmodule Vindinium do

  def start(secret, mode, turns, bot \\ Vindinium.Bots.Random) do
    Vindinium.Client.start
    state = start_game(secret, mode, turns)
    IO.puts "Watch game at: #{state["viewUrl"]}"
    move(state, secret, bot)
  end

  def start_game(secret, :training, turns) when is_integer(turns) do
    Vindinium.Client.post!(api_url("training"), {:form, [{:key, secret}, {:turns, turns}]}).body
  end

  def start_game(secret, :arena, _turns) do
    Vindinium.Client.post!(api_url("arena"), {:form, [{:key, secret}]}, [timeout: 10000]).body
  end

  def move(%{"game" => %{"finished" => true}} = state, _secret, _bot) do

    msg = case find_leader(state["game"]["heroes"]) do
      %{"name" => winner} ->
        "#{winner} won!"
      :draw ->
        "DRAW! No winner :("
    end

    IO.puts "\nGame ended – #{msg}"
  end

  def move(state, secret, bot) do
    IO.inspect state
    IO.write(".")
    Vindinium.Client.post!(state["playUrl"], {:form, [{:key, secret}, {:dir, bot.move(state)}]}).body
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

  def api_url(suffix) do
    Application.get_env(:vindinium, :api_url, "http://vindinium.org/api/") <> suffix
  end

end

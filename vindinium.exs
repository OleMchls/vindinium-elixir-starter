
{secret, mode, rounds} = case System.argv() do
  [secret, mode, rounds] -> {secret, String.to_atom(mode), String.to_integer(rounds) }
  [secret, mode] -> {secret, String.to_atom(mode), 300 }
  [secret] -> {secret, :training, 300 }
  _ -> throw "Usage: elixir script/vindinium <key> <[training|arena]> <number-of-turns>"
end

Vindinium.start(secret, mode, rounds, Vindinium.Bots.Random)

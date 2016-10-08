defmodule Vindinium.Client do
  use HTTPoison.Base

  @expected_fields ~w(
    game hero token viewUrl playUrl
  )

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.take(@expected_fields)
  end
end

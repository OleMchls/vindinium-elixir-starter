defmodule Vindinium.Client do
  use HTTPoison.Base

  @expected_fields ~w(
    game hero token viewUrl playUrl
  )

  def process_response_body(body) do
    body
    |> Poison.decode
    |> case do
      {:ok, data} ->
        Map.take(data, @expected_fields)
      _error ->
        raise "Invalid JSON response from server: #{inspect body}"
    end
  end
end

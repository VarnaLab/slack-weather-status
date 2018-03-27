defmodule SlackIcon do
  @moduledoc """
  Documentation for SlackIcon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> SlackIcon.hello
      :world

  """
  def change_icon do
   
    url = "https://api.darksky.net/forecast/#{Application.get_env(:slack_icon, :DARK_SKY_ACCESS_TOKEN)}/43.2095914,27.9133562"
    response = HTTPoison.get!(url)
    icon = Poison.decode!(response.body)["currently"]["icon"] 
    |> case do
      "crescent_moon" -> ":crescent_moon:"
      "sunny" ->  ":sunny:"
      "mostly_sunny" ->  ":mostly_sunny:"
      "partly_sunny" ->  ":partly_sunny:"
      "barely_sunny" ->  ":barely_sunny:"
      "partly_sunny_rain" ->  ":partly_sunny_rain:"
      "cloud" ->  ":cloud:"
      "rain_cloud" ->  ":rain_cloud:"
      "thunder_cloud_and_rain" ->  ":thunder_cloud_and_rain:"
      "lightning" -> ":zap:"
      "snow_cloud" ->  ":snow_cloud:"
      "fog" ->  ":foggy:"
      "clear-night"->":night_with_stars:"
      _ -> ":elixir-logo:"
    end
    params =
      %{
        "token" => Application.get_env(:slack_icon, :SLACK_ACCESS_TOKEN),
        "name" => "status_emoji",
        "value" => icon
      }
      |> URI.encode_query()

    HTTPoison.get!("https://slack.com/api/users.profile.set?#{params}", [
      {"Content-Type", "application/json"}
    ])
    
  end
end

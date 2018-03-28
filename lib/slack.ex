defmodule Slack do
  def get_icon(key) do
    case key do
      "clear-day" -> ":sunny:"
      "clear-night" -> ":night_with_stars:"
      "rain" -> ":partly_sunny_rain:"
      "snow" -> ":snowflake:"
      "sleet" -> ":snow_cloud:"
      "wind" -> ":wind_blowing_face:"
      "fog" -> ":foggy:"
      "cloudy" -> ":cloud:"
      "partly-cloudy-day" -> ":sun_behind_cloud:"
      "partly-cloudy-night" -> ":waning_crescent_moon:"
      _ -> IO.puts('Unknown')
    end
  end
  
  def retrieve() do
    darkskyApiKey = System.get_env("DARKSKY_API_KEY")
    icon = HTTPoison.get!('https://api.darksky.net/forecast/#{darkskyApiKey}/43.2095914,27.9133562')
    |> Map.get(:body)
    |> Poison.decode!
    |> Map.get("currently")
    |> Map.get("icon")
    |> Slack.get_icon

    IO.inspect(icon)

    HTTPoison.get!(
      "https://slack.com/api/users.profile.set?" <>
      URI.encode_query(%{
            token: System.get_env("SLACK_API_KEY"),
            name: "status_emoji",
            value: icon
                       }), [{"Content-Type", "application/json"}])
    |> Map.get(:body)
    |> Poison.decode!
    |> IO.inspect()
  end
end

defmodule Weather.DarkskyAPI do
  def get_current_weather_icon() do
    key = System.get_env("DARKSKY_API_KEY")

    HTTPoison.get!("https://api.darksky.net/forecast/#{key}/43.2095914,27.9133562")
    |> Map.get(:body)
    |> Jason.decode!()
    |> Map.get("currently")
    |> Map.get("icon")
    |> transform_icon()
  end

  defp transform_icon(required_icon) do
    %{
      "clear-day" => ":sunny:",
      "clear-night" => ":crescent_moon:",
      "rain" => ":rain_cloud:",
      "snow" => ":snow_cloud:",
      "sleet" => ":thunder_cloud_and_rain:",
      "wind" => ":mostly_sunny:",
      "fog" => ":fog:",
      "cloudy" => ":cloud:",
      "partly-cloudy-day" => ":partly_sunny:",
      "partly-cloudy-night" => ":crescent_moon:"
    }
    |> Map.get(required_icon, ":barely_sunny:")
  end
end

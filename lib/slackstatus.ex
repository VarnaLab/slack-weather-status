defmodule Slackstatus do
  @moduledoc """
  Documentation for Slackstatus.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Slackstatus.hello
      :world

  """
  def hello do
    :world
  end

  def receive do
    HTTPoison.get!("https://api.darksky.net/forecast/5ab2a0f80b077cfa71d8fc360e7c1c8a/43.2095914,27.9133562")
    |> Map.get(:body)
    |> Jason.decode!()
    |> Map.get("currently")
    |> Map.get("icon")
    #|> IO.inspect()
  end

  def mapper() do
    receive()
    |> case do
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

  def changeStatus do
    icon = mapper()
    IO.inspect(icon)
    HTTPoison.get!("https://slack.com/api/users.profile.set?" <>
    URI.encode_query(%{
      token: "xoxp-25361130448-249453046706-337121773478-21aafcd6a3b9fa83e7365dc98e84188f",
      name: "status_emoji",
      value: icon
        }), [{"Content-Type", "application/json"}])
    |> Map.get(:body)
    |> Jason.decode!()
    |> IO.inspect()
  end
end

#clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night
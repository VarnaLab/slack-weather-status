
fn config ->
  HTTPoison.get!(
    "https://api.darksky.net/forecast/#{config["apikey"]}/#{config["location"]}",
    [],
    [ params: [{:exclude, "minutely,hourly,daily,alerts,flags"}] ]
  )
  |> fn obj -> %{
    "clear-day" => "sunny",
    "clear-night" => "crescent_moon",
    'rain' => 'rain_cloud',
    'snow' => 'snow_cloud',
    'sleet' => 'snowflake',
    'wind' => 'wind_blowing_face',
    'fog' => 'fog',
    'cloudy' => 'cloud',
    'partly-cloudy-day' => 'partly_sunny',
    'partly-cloudy-night' => 'new_moon',
    'thunderstorm' => 'lightning',
    'tornado' => 'tornado'
  }[Poison.decode!(obj.body)["currently"]["icon"]] end.()
  |> fn emoji -> HTTPoison.post!(
    "https://slack.com/api/users.profile.set",
    {:form, [profile: Poison.encode!(
      %{"status_text" => "(⌐■_■)", "status_emoji" => ":#{emoji}:"})]},
    %{"authorization" => "Bearer #{config["token"]}"}
  ) end.()
end.(Poison.decode!(File.read!(Path.expand(List.first(System.argv)))))

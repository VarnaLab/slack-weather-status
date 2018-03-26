defmodule Weather do
  def update_icon do
    Weather.DarkskyAPI.get_current_weather_icon()
    |> Weather.SlackAPI.set_icon()
  end
end

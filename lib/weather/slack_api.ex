defmodule Weather.SlackAPI do
  def set_icon(icon) do
    query =
      %{
        "token" => System.get_env("SLACK_API_KEY"),
        "name" => "status_emoji",
        "value" => icon
      }
      |> URI.encode_query()

    HTTPoison.get!("https://slack.com/api/users.profile.set?#{query}", [
      {"Content-Type", "application/json"}
    ])

    :ok
  end
end

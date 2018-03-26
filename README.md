
# Elixir Project 1: Update user's status icon in Slack based on the current weather forecast for Varna

1. Authenticate with Slack using [this link](https://grant.outofindex.com/slack), choose `users.profile:write` scope, and save the returned _access token_
2. Create a script that makes GET request to `https://api.darksky.net/forecast/[key]/[latitude],[longitude]` where:
  - `key` is API key from https://darksky.net/dev
  - `lat,long` for Varna is `43.2095914,27.9133562`
3. Map the returned weather icon to emoji shortcode like
  ```
  crescent_moon sunny mostly_sunny partly_sunny barely_sunny partly_sunny_rain cloud rain_cloud thunder_cloud_and_rain lightning snow_cloud fog
  ```
4. Make POST request to https://api.slack.com/methods/users.profile.set using the access token and the emoji shortcode
5. Push the code to https://github.com/VarnaLab
6. Run the script with Crontab on every 5 minutes


# slack-weather-status

## install

```bash
mix deps.get
```

## run

```bash
mix run slacker.exs config.json
```

## config.json

```json
{
  "apikey": "[darksky API key]",
  "location": "43.2095914,27.9133562",
  "token": "[slack access token]"
}
```

## crontab

```bash
# every 15 min
*/15 * * * * mix run slacker.exs config.json
```

#!/usr/bin/env bash

handle_error() {
  printf "Weather error: %s\n" "$1" >&2
  exit 1
}

if ! weather=$(
  curl --fail --silent \
    --connect-timeout 5 \
    --max-time 15 \
    "https://wttr.in?format=j1"
); then
  handle_error "Failed to fetch weather data."
fi

if [[ -z "$weather" ]]; then
  handle_error "Weather service returned an empty response."
fi

if ! weather=$(printf "%s\n" "$weather" | jq -c "." 2>/dev/null); then
  handle_error "Weather service returned invalid JSON."
fi

printf "%s\n" "$weather"

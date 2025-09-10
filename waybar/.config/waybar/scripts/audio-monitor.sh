#!/bin/bash

get_audio_info() {
  # Get current volume and mute status
  VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -1)
  MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )\w+')

  # Choose icon based on volume level and mute status
  if [ "$MUTED" = "yes" ]; then
    ICON=""
    CLASS="muted"
  elif [ "$VOLUME" -gt 70 ]; then
    ICON=""
    CLASS="high"
  else
    ICON=""
    CLASS="low"
  fi

  echo "{\"text\":\"$ICON  $VOLUME%\", \"percentage\":$VOLUME, \"class\":\"$CLASS\", \"tooltip\":\"Volume: $VOLUME%\"}"
}

get_audio_info
pactl subscribe | grep --line-buffered "Event 'change' on sink" | while read -r line; do
  get_audio_info
done

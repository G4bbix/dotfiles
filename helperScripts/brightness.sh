#!/usr/bin/env zsh

# Set brightness of all screens

BRIGHTNESS="$(xrandr --prop --verbose | grep Bright | head -1  | cut -d " " -f2)"
OPERATOR="${1:0:1}"
VALUE="${1:1:$}"

if [ "$OPERATOR" = "+" ] && [ "$BRIGHTNESS" != "1.0" ] ; then
  for SCREEN in $(xrandr | grep -w connected | cut -d " " -f1) ; do
    xrandr --output "$SCREEN" --brightness $(( BRIGHTNESS + VALUE))
  done
elif [ "$OPERATOR" = "-" ] ; then
  if [ "$(echo "$BRIGHTNESS - $VALUE > 0.10" | bc)" = 1 ] ; then
    for SCREEN in $(xrandr | grep -w connected | cut -d " " -f1) ; do
      xrandr --output "$SCREEN" --brightness $(( BRIGHTNESS - VALUE))
    done
  fi
fi

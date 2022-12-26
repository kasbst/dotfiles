#!/bin/ksh

pkill polybar > /dev/null 2>&1

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ "$m" != "DP-2" ]]; then
       MONITOR=$m polybar --reload -c ~/.config/polybar/config monitor &
    fi
  done
else
  polybar --reload -c ~/.config/polybar/config monitor &
fi

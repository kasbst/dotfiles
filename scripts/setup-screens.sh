#!/bin/ksh

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ "$m" == "DP-3" ]]; then
       xrandr --output DP-3 --primary
    fi

    if [[ "$m" == "eDP-1" ]]; then
       xrandr --output eDP-1 --right-of DP-3
    fi

    if [[ "$m" == "DP-2" ]]; then
       xrandr --output DP-2 --rotate right --left-of DP-3
    fi
  done
fi

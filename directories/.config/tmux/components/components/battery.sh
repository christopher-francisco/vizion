#!/bin/sh

# battery=$(pmset -g batt | awk '{print $3}' | sed 's/;//')
icon=$(tmux show -gv "@c_battery_icon")
text=$(pmset -g batt | grep -o "[0-9]\{1,3\}%")

battery="$icon $text"
tmux set -g @c_battery "$battery"
# tmux set -g @c_battery "Energy: 90%"

echo "$battery"

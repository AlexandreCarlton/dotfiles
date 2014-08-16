#!/bin/sh

volume=$(amixer get Master | grep "Left: " | egrep -o "[0-9]+%" | egrep -o "[0-9]*")
is_muted=$(amixer get Master | egrep -o "\[off\]")

MUTE_ICON="\uE04F"
LOW_ICON="\uE04E"
MEDIUM_ICON="\uE050"
HIGH_ICON="\uE05D"

if [[ ! -z $is_muted ]]; then
    icon=$MUTE_ICON
else
    if [[ $volume -le 33 ]]; then
        icon=$LOW_ICON
    elif [[ $volume -le 66 ]]; then
        icon=$MEDIUM_ICON
    else
        icon=$HIGH_ICON
    fi
fi

echo -e "$icon $volume"

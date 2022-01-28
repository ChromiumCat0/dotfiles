#!/bin/bash

PATH_AC="/sys/class/power_supply/AC"
PATH_BATTERY_0="/sys/class/power_supply/BAT0"
PATH_BATTERY_1="/sys/class/power_supply/BAT1"

ac=0
battery_level_0=0
battery_level_1=0
battery_max_0=0
battery_max_1=0

if [ -f "$PATH_AC/online" ]; then
    ac=$(cat "$PATH_AC/online")
fi

if [ -f "$PATH_BATTERY_0/capacity" ]; then
    battery_level_0=$(cat "$PATH_BATTERY_0/capacity")
	battery_max_0=100
fi

if [ -f "$PATH_BATTERY_1/capacity" ]; then
    battery_level_1=$(cat "$PATH_BATTERY_1/capacity")
    battery_max_1=100
fi

battery_level=$(("$battery_level_0 + $battery_level_1"))
battery_max=$(("$battery_max_0 + $battery_max_1"))

battery_percent=$(("$battery_level * 100"))
battery_percent=$(("$battery_percent / $battery_max"))

if [ "$ac" -eq 1 ]; then
    icon=""
	echo "$icon $battery_percent%"
else
    if [ "$battery_percent" -gt 80 ]; then
        icon=""
    elif [ "$battery_percent" -gt 60 ]; then
        icon=""
    elif [ "$battery_percent" -gt 40 ]; then
        icon=""
	elif [ "$battery_percent" -gt 20 ]; then
		icon=""
	else
        icon=""
    fi

    echo "$icon $battery_percent%"
fi

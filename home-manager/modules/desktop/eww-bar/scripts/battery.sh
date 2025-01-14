#!/bin/sh

bat=/sys/class/power_supply/BAT0/
per="$(cat "$bat/capacity")"

icon() {
    charge=[ $(cat "$bat/status") = Charging ] && echo "" || echo ""

    if [ "$per" -gt "90" ]; then
        icon="󰁹"
    elif [ "$per" -gt "80" ]; then
        icon="󰂂"
    elif [ "$per" -gt "70" ]; then
        icon="󰂀"
    elif [ "$per" -gt "60" ]; then
        icon="󰁿"
    elif [ "$per" -gt "50" ]; then
        icon="󰁾"
    elif [ "$per" -gt "40" ]; then
        icon="󰁽"
    elif [ "$per" -gt "30" ]; then
        icon="󰁼"
    elif [ "$per" -gt "20" ]; then
        icon="󰁻"
    elif [ "$per" -gt "10" ]; then
        icon="󰁺"
        notify-send -u critical "Battery Low" "Connect Charger"
    elif [ "$pera" -gt "0" ]; then
        icon="󰂃 "
        notify-send -u critical "Battery Low" "Connect Charger"
    else
            echo "x" && exit
    fi
    echo "$icon$charge"
}

percent() {
    echo $per
}
status() {
    status="$(cat "$bat"/status)"
    echo $status
}

[ "$1" = "icon" ] && icon && exit
[ "$1" = "percent" ] && percent && exit
[ "$1" = "status" ] && status && exit
exit

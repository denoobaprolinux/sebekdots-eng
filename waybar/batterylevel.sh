#!/bin/bash

GOOD_LEVEL=95
WARNING_LEVEL=20
CRITICAL_LEVEL=15
STATE_FILE="/tmp/battery_notification_state"

BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)

if [ -f "$STATE_FILE" ]; then
    PREVIOUS_STATE=$(cat "$STATE_FILE")
else
    PREVIOUS_STATE="normal"
fi

if [[ "$BATTERY_STATUS" == "Discharging" ]]; then
    if [[ "$BATTERY_LEVEL" -le $CRITICAL_LEVEL && "$PREVIOUS_STATE" != "critical" ]]; then
        notify-send -u critical "Battery Critical" "Battery at $BATTERY_LEVEL%. Connect the charger."
        echo "critical" > "$STATE_FILE"

    elif [[ "$BATTERY_LEVEL" -le $WARNING_LEVEL && "$BATTERY_LEVEL" -gt $CRITICAL_LEVEL && "$PREVIOUS_STATE" != "warning" ]]; then
        notify-send -u normal "Low Battery" "Battery at $BATTERY_LEVEL%. Consider to connect your charger."
        echo "warning" > "$STATE_FILE"

    elif [[ "$BATTERY_LEVEL" -gt $WARNING_LEVEL && "$PREVIOUS_STATE" != "normal" ]]; then
        echo "normal" > "$STATE_FILE"
    fi
fi

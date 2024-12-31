#!/bin/bash

# Initial state of Waybar
WAYBAR_HIDDEN=0

# Function to hide Waybar
hide_waybar() {
    if [ "$WAYBAR_HIDDEN" -eq 0 ]; then
        pkill -USR2 waybar
        WAYBAR_HIDDEN=1
    fi
}

# Function to show Waybar
show_waybar() {
    if [ "$WAYBAR_HIDDEN" -eq 1 ]; then
        pkill -USR2 waybar
        WAYBAR_HIDDEN=0
    fi
}

# Continuous check of window states
while true; do
    # Get the list of active windows
    ACTIVE_WINDOWS=$(hyprctl clients | grep "window:")

    if [ -n "$ACTIVE_WINDOWS" ]; then
        hide_waybar
    else
        show_waybar
    fi

    # Check interval
    sleep 0.5
done

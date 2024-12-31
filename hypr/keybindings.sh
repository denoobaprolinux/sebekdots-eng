#!/bin/bash

# GDK BACKEND. 
BACKEND=wayland

# Check if Rofi is executed, and if so, closes it
if pgrep -x "rofi" > /dev/null; then
    pkill rofi
fi

# Detects monitor and scale
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Calculates size of the window based on resolution
width=$((x_mon * hypr_scale / 100))
height=$((y_mon * hypr_scale / 100))

# Sets max height and width
max_width=1200
max_height=1000

# Dynamic size based on screen size
percentage_width=70
percentage_height=70

# Calculates dynamic height and width
dynamic_width=$((width * percentage_width / 100))
dynamic_height=$((height * percentage_height / 100))

# Limits height and width of the window
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

# Execute yad using all previous parameters
GDK_BACKEND=$BACKEND yad --width=$dynamic_width --height=$dynamic_height \
    --center \
    --title="Keybinds - Sebekdots" \
    --no-buttons \
    --list \
    --column=Keys: \
    --column=Description: \
    --column=Command/Function/Program: \
    --timeout-indicator=top \
"  + A" "Open this Window" "" \
"ESC" "Close this Window" "Also with   + Q" \
"  + Enter" "Terminal" "kitty" \
"  + Q" "Close Active Window" "Hyprland Built-in Function" \
"  + M" "Close Hyprland" "Hyprland Built-in Function" \
"  + H" "Reload Hyprland Custom Options" "Script hyprctl.sh" \
"  + Shift + H" "Hyprland Settings Menu" "Script hyprctl.sh" \
"  + SHIFT + R" "Reload Waybar" "Script reload.sh" \
"  + Shift + Q" "Load Default Waaybar" "Classic/Down Bar" \
"  + E" "Open File Manager" "Nautilus" \
"  + F" "Open Web Browser" "Firefox" \
"  + N" "Open Notification Center" "Sway Notification Center" \
"  + W" "Choose Random Wallpaper" "Script wallpaper.sh random" \
"  + Shift + B" "Select Waybar Theme" "Script themeswitcher.sh" \
"  + B" "Show/Hide Waybar" "Waybar" \
"  + L" "Lock Screen" "Hyprlock" \
"  + V" "Floating Window" "Focused Window" \
"  + D" "Pseudo Fullscreen Option" "On/Off Toggle Switch" \
"  + P" "Pseudo Dwindle" "Hyprland Built-in Function" \
"  + J" "Change Window Layout" "Horizontal/Vertical Layout Switch" \
"  + Shift + T" "Enable/Disable Tab Mode" "Hyprland Built-in Function" \
"  + TAB" "Open/Close Overview Mode" "Hyprexpo" \
"  + S" "Minimize/Maximize Active Window" "Special Workspace" \
"PrintScreen" "Take a Screenshot" "grim + swappy" \
"  + PrintScreen" "Select Screenshot Area" "grim + slurp + swappy" \
"CTRL + PrintScreen" "Quick Screenshot (No Edition Mode)" "Script grimblast.sh" \
"Shift Izq. + Shift Der." "Change Keyboard Layout" "Hyprland Built-in Function" \
"" "" "" \

#!/bin/bash

# ----------------------------------------------------- 
# CKill Waybar and Swaync
# ----------------------------------------------------- 
killall waybar
killall swaync
sleep 0.2

# ----------------------------------------------------- 
# Gather current info from themestyle.sh
# ----------------------------------------------------- 
if [ -f ~/.cache/.themestyle.sh ]; then
    themestyle=$(cat ~/.cache/.themestyle.sh)
else
    touch ~/.cache/.themestyle.sh
    echo "$themestyle" > ~/.cache/.themestyle.sh
fi

IFS=';' read -ra arrThemes <<< "$themestyle"
echo ${arrThemes[0]}

if [ ! -f ~/.config/waybar/themes${arrThemes[1]}/style.css ]; then
    themestyle="/classicdown;/classicdown"
fi

# ----------------------------------------------------- 
# Load Configuration
# ----------------------------------------------------- 

config_file="config"
style_file="style.css"

# Check used files
echo "Config: $config_file"
echo "Style: $style_file"

waybar -c ~/.config/waybar/themes${arrThemes[0]}/$config_file -s ~/.config/waybar/themes${arrThemes[1]}/$style_file &
sleep 3 && ~/.config/hypr/hyprctl.sh

# Choosing Swaync configuration according to waybar theme

themestyle=$(cat ~/.cache/.themestyle.sh)

if [[ $themestyle == *up* ]]; then
    killall swaync 
    swaync -c ~/.config/sncup/config.json -s ~/.config/sncup/style.css &
fi
if [[ $themestyle == *abajo* ]]; then
    killall swaync
    swaync -c ~/.config/sncdown/config.json -s ~/.config/sncdown/style.css &
fi
if [[ $themestyle == *izquierda* ]]; then
    killall swaync
    swaync -c ~/.config/sncleft/config.json -s ~/.config/sncleft/style.css &
fi
if [[ $themestyle == *bezeldown* ]]; then
    killall swaync
    swaync -c ~/.config/sncdowncenter/config.json -s ~/.config/sncdowncenter/style.css &
fi
if [[ $themestyle == *bezelup* ]]; then
    killall swaync
    swaync -c ~/.config/sncupcenter/config.json -s ~/.config/sncupcenter/style.css &
fi
if [[ $themestyle == *revealerup* ]]; then
    killall swaync
    swaync -c ~/.config/sncupcenter/config.json -s ~/.config/sncupcenter/style.css &
fi
if [[ $themestyle == *revealerdown* ]]; then
    killall swaync
    swaync -c ~/.config/sncdowncenter/config.json -s ~/.config/sncdowncenter/style.css &
fi

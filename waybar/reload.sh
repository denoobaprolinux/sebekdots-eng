#!/bin/bash
# Kill and reload Waybar when configuration changes

killall waybar &
   
if [ -f ~/.cache/.themestyle.sh ]; then
    themestyle=$(cat ~/.cache/.themestyle.sh)
else
    touch ~/.cache/.themestyle.sh
    echo "$themestyle" > ~/.cache/.themestyle.sh
fi

IFS=';' read -ra arrThemes <<< "$themestyle"
echo ${arrThemes[0]}

# ----------------------------------------------------- 
# Loading configuration
# ----------------------------------------------------- 
config_file="config"
style_file="style.css"

if [ -f ~/dotfiles/waybar/themes${arrThemes[0]}/config-custom ] ;then
    config_file="config-custom"
fi
if [ -f ~/dotfiles/waybar/themes${arrThemes[1]}/style-custom.css ] ;then
    style_file="style-custom.css"
fi

# Check used archives by new bar and load Hyprland custom configurations
echo "Config: $config_file"
echo "Style: $style_file"

waybar -c ~/.config/waybar/themes${arrThemes[0]}/$config_file -s ~/.config/waybar/themes${arrThemes[1]}/$style_file &
sleep 1
~/.config/hypr/hyprctl.sh

# Functions to determine which Swaync will be loaded

themestyle=$(cat ~/.cache/.themestyle.sh)

if [[ $themestyle == *up* ]]; then
    killall swaync 
    swaync -c ~/.config/sncup/config.json -s ~/.config/sncup/style.css &
fi
if [[ $themestyle == *down* ]]; then
    killall swaync
    swaync -c ~/.config/sncdown/config.json -s ~/.config/sncdown/style.css &
fi
if [[ $themestyle == *left* ]]; then
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
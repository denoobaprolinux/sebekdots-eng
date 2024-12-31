#!/bin/bash

killall waybar && killall swaync
waybar -c ~/.config/waybar/themes/classicdown/config -s ~/.config/waybar/themes/classicdown/style.css &
swaync -c ~/.config/sncdown/config.json -s ~/.config/sncdown/style.css &
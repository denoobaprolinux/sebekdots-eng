#!/bin/bash

# Launch nwg-menu with Sebekdots parameters

nwg-menu -va top -ml 5 -mt 5 -cmd-lock "hyprlock" -cmd-logout "hyprctl dispatch exit" -cmd-restart "reboot" -cmd-shutdown "poweroff" -fm "nautilus" -d -isl 20 -iss 10

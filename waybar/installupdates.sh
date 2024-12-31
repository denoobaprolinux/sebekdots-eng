#!/bin/bash

# ----------------------------------------------------- 
# Required: yay, trizen. Optional: flatpak, snapd
# ----------------------------------------------------- 

sleep 1
clear

cat <<"EOF"
 _   _           _       _            
| | | |_ __   __| | __ _| |_ ___  ___ 
| | | | '_ \ / _` |/ _` | __/ _ \/ __|
| |_| | |_) | (_| | (_| | ||  __/\__ \
 \___/| .__/ \__,_|\__,_|\__\___||___/
      |_|                             
EOF

# ------------------------------------------------------
# Flag to verify if updates were applied
# ------------------------------------------------------
updates_performed=false
all_updates_skipped=true 

# ------------------------------------------------------
# Handling User Interruptions (Ctrl+C)
# ------------------------------------------------------
trap "echo 'Interrupted Updates . Nothing was installed.'; notify-send 'Update Center:' 'Cancelled Updates'; exit 1" SIGINT

# ------------------------------------------------------
# Verify flatpak updates
# ------------------------------------------------------
_updateFlatpak() {
    updates_flatpak=0
    if command -v flatpak > /dev/null 2>&1; then
        updates_flatpak=$(flatpak update --appstream 2> /dev/null | grep -c 'Update:')
        if [ "$updates_flatpak" -gt 0 ];then
            echo "Flatpak updates available: $updates_flatpak"
            read -p "Do you want to update Flatpak? (y/n): " flatpak_confirm
            if [[ "$flatpak_confirm" =~ [yY] ]]; then
                flatpak update
                updates_performed=true
                all_updates_skipped=false
            fi
        else
            echo "No Flatpak updates available."
        fi
    else
        echo "Flatpak is not installed in your system."
    fi
    return $updates_flatpak
}

# ------------------------------------------------------
# Verify snapd updates
# ------------------------------------------------------
_updateSnap() {
    updates_snap=0
    if command -v snap > /dev/null 2>&1; then
        updates_snap=$(snap refresh --list 2> /dev/null | wc -l)
        if [ "$updates_snap" -gt 0 ];then
            echo "Snap updates available: $updates_snap"
            read -p "Do you want to update Snap? (y/n): " snap_confirm
            if [[ "$snap_confirm" =~ [yY] ]]; then
                snap refresh
                updates_performed=true
                all_updates_skipped=false
            fi
        else
            echo "No Snap updates available."
        fi
    else
        echo "Snap is not installed in your system."
    fi
    return $updates_snap
}

# ------------------------------------------------------
# Starting updates
# ------------------------------------------------------

while true; do
    read -p "Do you want to install updates? (y/n): " yn
    case $yn in
        [yY]* )
            echo ""
            break;;
        [nN]* ) 
            notify-send "Update Center:" "Updates were cancelled"
            exit;
            ;;
        * ) echo "Answer using y or n.";;
    esac
done

echo "-----------------------------------------------------"
echo "Syncing Arch Linux packages database"
echo "-----------------------------------------------------"

sudo pacman -Sy

echo "-----------------------------------------------------"
echo "Starting Updates"
echo "-----------------------------------------------------"

# Check Pacman (Main Repos)
updates_pacman=$(checkupdates | wc -l)

if [ "$updates_pacman" -gt 0 ];then
    echo "Pacman updates available: $updates_pacman"
    read -p "Do you want to update Pacman? (y/n): " pacman_confirm
    if [[ "$pacman_confirm" =~ [yY] ]];then
        sudo pacman -Su
        updates_performed=true
        all_updates_skipped=false
    fi
else
    echo "No Pacman updates available."
fi

# Verify yay updates (AUR)
updates_yay=$(yay -Qu --aur | wc -l)

if [ "$updates_yay" -gt 0 ];then
    echo "Yay updates available: $updates_yay"
    read -p "Do you want to update Yay? (y/n): " yay_confirm
    if [[ "$yay_confirm" =~ [yY] ]];then
        yay --aur -Syua
        updates_performed=true
        all_updates_skipped=false
    fi
else
    echo "No Yay updates available."
fi

# Update Flatpak if available
_updateFlatpak
updates_flatpak=$?

# Update Snap if available
_updateSnap
updates_snap=$?

# ------------------------------------------------------
# Tooltip with detailed information
# ------------------------------------------------------
tooltip=""

if [ "$updates_pacman" -gt 0 ];then
    tooltip+="Pacman/Yay: $updates_pacman updates\n"
fi

if [ "$updates_flatpak" -gt 0 ];then
    tooltip+="Flatpak: $updates_flatpak updates\n"
fi

if [ "$updates_snap" -gt 0 ];then
    tooltip+="Snap: $updates_snap updates\n"
fi

# If no updates
if [ -z "$tooltip" ];then
    tooltip="No pending updates."
fi

# ------------------------------------------------------
# Verify if updates were performed
# ------------------------------------------------------
if [ "$updates_pacman" -eq 0 ] && [ "$updates_yay" -eq 0 ] && [ "$updates_flatpak" -eq 0 ] && [ "$updates_snap" -eq 0 ];then
    notify-send "Update Center:" "Nothing was done"
elif [ "$updates_performed" = true ];then
    total_updates=$(("$updates_pacman" + "$updates_yay" + "$updates_flatpak" + "$updates_snap"))
    notify-send --transient "Update Center:" "$total_updates installed updates"
else
    notify-send --transient "Update Center:" "Update cancelled or interrupted."
fi

# ------------------------------------------------------
# Quick Waybar reload
# ------------------------------------------------------
sleep 2
~/.config/waybar/updates.sh
pkill -SIGUSR2 waybar


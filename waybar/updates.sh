#!/bin/sh

# -----------------------------------------------------
# Requires pacman-contrib, trizen, flatpak, snapd
# -----------------------------------------------------

# Threshold for icon colors
threshold_green=1
threshold_yellow=25
threshold_red=50

# -----------------------------------------------------
# Verify Updates - Pacman/Trizen (AUR)
# -----------------------------------------------------

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l); then
    updates_arch=0
fi

if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
    updates_aur=0
fi

# -----------------------------------------------------
# Verify Updates - Flatpak/Snap
# -----------------------------------------------------

# Check if flatpack is installed
if command -v flatpak > /dev/null 2>&1; then
    if ! updates_flatpak=$(flatpak update --assumeyes | grep -c 'Update:'); then
        updates_flatpak=0
    fi
else
    updates_flatpak=0
fi

# Check if snapd is installed
if command -v snap > /dev/null 2>&1; then
    if ! updates_snap=$(snap refresh --list | wc -l); then
        updates_snap=0
    fi
else
    updates_snap=0
fi

# -----------------------------------------------------
# Totalize all updates to generate info on icon
# -----------------------------------------------------

total_updates=$(("$updates_arch" + "$updates_aur" + "$updates_flatpak" + "$updates_snap"))

# -----------------------------------------------------
# Define classes according to threshold
# -----------------------------------------------------

if [ "$total_updates" -ge $threshold_red ]; then
    css_class="red"
elif [ "$total_updates" -ge $threshold_yellow ]; then
    css_class="yellow"
elif [ "$total_updates" -ge $threshold_green ]; then
    css_class="green"
else
    css_class="white"
fi

# -----------------------------------------------------
# Tooltip
# -----------------------------------------------------

tooltip=""
if [ "$updates_arch" -gt 0 ] || [ "$updates_aur" -gt 0 ]; then
    tooltip+="Pacman/Yay: $(("$updates_arch" + "$updates_aur")) Updates\n"
fi

if [ "$updates_flatpak" -gt 0 ]; then
    tooltip+="Flatpak: $updates_flatpak Updates\n"
fi

if [ "$updates_snap" -gt 0 ]; then
    tooltip+="Snap: $updates_snap Updates\n"
fi

if [ -z "$tooltip" ]; then
    tooltip="No Updates."
fi

# -----------------------------------------------------
# Actualiza el ícono y tooltip en Waybar
# -----------------------------------------------------
echo "{\"text\": \"$total_updates\", \"tooltip\": \"$tooltip\", \"class\": \"$css_class\"}"

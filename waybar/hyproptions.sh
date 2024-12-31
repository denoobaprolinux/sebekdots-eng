#!/bin/bash

# Options displayed in Rofi

declare -A options=(
    ["1. Default Configuration"]="Accept Back"
    ["2. Window Border Width"]="numeric"
    ["3. Internal Gaps"]="numeric"
    ["4. External Gaps"]="numeric"
    ["5. Smart Gaps"]="1.On 2.Off 3.Back"
    ["6. Blur Effect"]="1.On 2.Off 3.Back"
    ["7. Neon Effect"]="1.On 2.Off 3.Back"
    ["8. Neon Effect - Range"]="numeric"
    ["9. Neon Effect - Intensity"]="numeric"
    ["10. Resize Windows"]="1.On 2.Off 3.Back"
    ["11. Resize Windows - Area"]="numeric"
    ["12. Corners"]="numeric"
    ["13. Animations"]="1.Off 2.Standard 3.Fade 4.Fast 5.Fluid 6.Maximum"
    ["14. Dimming"]="1.On 2.Off 3.Back"
    ["15. Dimming - Intensity"]="numeric"
    ["16. Opacity (Active Window)"]="numeric"
    ["17. Opacity (Inactive Window)"]="numeric"
    ["18. X-Ray Effect"]="1.On 2.Off 3.Back"
)

# Creating/Updating hyprctl.sh script

hyprctl_script=~/.config/hypr/hyprctl.sh

if [ ! -f "$hyprctl_script" ]; then
    echo "#!/bin/bash" > "$hyprctl_script"
    chmod +x "$hyprctl_script"
fi

# Update hyprctl.sh each time there is a change

update_hyprctl_script() {
    local key=$1
    local value=$2
    local file=$3
    local pattern="^hyprctl keyword $key"

    if grep -q "$pattern" "$file"; then
        sed -i "s|$pattern.*|hyprctl keyword $key $value|" "$file"
    else
        echo "hyprctl keyword $key $value" >> "$file"
    fi
}

# Selecting options in Rofi

selected_option=$(printf "%s\n" "${!options[@]}" | sort -n | rofi -dmenu -i -replace -config "$HOME/.config/rofi/config-hypr.rasi" -no-show-icons -width 30 "Select Hyprland option:")

if [ -n "$selected_option" ]; then
    option_type=${options[$selected_option]}
    if [ "$option_type" == "numeric" ]; then
        selected_value=$(rofi -dmenu -i -replace -config "$HOME/.config/rofi/config-submenu.rasi" -no-show-icons -width 30 "Enter value for $selected_option:")
    else
        selected_value=$(printf "%s\n" $option_type | sort | rofi -dmenu -i -replace -config "$HOME/.config/rofi/config-submenu.rasi" -no-show-icons -width 30 "Select value for $selected_option:")
    fi

    if [ -n "$selected_value" ]; then
        case $selected_option in
            "1. Default Configuration")
                case $selected_value in 
                    "Accept")
                        hyprctl reload
                        echo "#!/bin/bash" > "$hyprctl_script"
                        chmod +x "$hyprctl_script"
                        cp ~/.config/hypr/config/animations/animations-default.conf ~/.config/hypr/config/animations.conf
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "Back")
                        ~/.config/waybar/hyproptions.sh
                esac
                ;;
            "2. Window Border Width")
                hyprctl keyword general:border_size "$selected_value"
                update_hyprctl_script "general:border_size" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "3. Internal Gaps")
                hyprctl keyword general:gaps_in "$selected_value"
                update_hyprctl_script "general:gaps_in" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "4. External Gaps")
                hyprctl keyword general:gaps_out "$selected_value"
                update_hyprctl_script "general:gaps_out" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "5. Smart Gaps")
                case $selected_value in
                    "1.On")
                        cp ~/.config/hypr/config/gaps/gaps_on.conf ~/.config/hypr/config/gaps.conf
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "2.Off")
                        cp ~/.config/hypr/config/gaps/gaps_off.conf ~/.config/hypr/config/gaps.conf
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "3.Back")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "6. Blur Effect")
                case $selected_value in
                    "1.On")
                        hyprctl keyword decoration:blur:enabled true
                        update_hyprctl_script "decoration:blur:enabled" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "2.Off")
                        hyprctl keyword decoration:blur:enabled false
                        update_hyprctl_script "decoration:blur:enabled" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "3.Back")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "7. Neon Effect")
                case $selected_value in
                    "1.On")
                        hyprctl keyword decoration:drop_shadow true
                        update_hyprctl_script "decoration:shadow:enabled" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "2.Off")
                        hyprctl keyword decoration:drop_shadow false
                        update_hyprctl_script "decoration:shadow:enabled" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "3.Back")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "8. Neon Effect - Range")
                hyprctl keyword decoration:shadow_range "$selected_value"
                update_hyprctl_script "decoration:shadow:range" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "9. Neon Effect - Intensity")
                hyprctl keyword decoration:shadow_range "$selected_value"
                update_hyprctl_script "decoration:shadow:render_power" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "10. Resize Windows")
                case $selected_value in
                    "1.On")
                        hyprctl keyword general:resize_on_border true
                        update_hyprctl_script "general:resize_on_border" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "2.Off")
                        hyprctl keyword general:resize_on_border false
                        update_hyprctl_script "general:resize_on_border" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "3.Back")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "11. Resize Windows - Area")
                hyprctl keyword general:extend_border_grab_area "$selected_value"
                update_hyprctl_script "general:extend_border_grab_area" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "12. Corners")
                hyprctl keyword decoration:rounding "$selected_value"
                update_hyprctl_script "decoration:rounding" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "13. Animations")
                case $selected_value in
                    "1.Off")
                        update_hyprctl_script "animations:enabled" "false" "$hyprctl_script"
                        ;;
                    "2.Standard")
                        cp ~/.config/hypr/config/animations/animations-default.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "3.Fade")
                        cp ~/.config/hypr/config/animations/animations-fade.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "4.Fast")
                        cp ~/.config/hypr/config/animations/animations-fast.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "5.Fluid")
                        cp ~/.config/hypr/config/animations/animations-fluid.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                    "6.Maximum")
                        cp ~/.config/hypr/config/animations/animations-maximum.conf ~/.config/hypr/config/animations.conf
                        update_hyprctl_script "animations:enabled" "true" "$hyprctl_script"
                        ;;
                esac
                ~/.config/waybar/hyproptions.sh
                ;;
            "14. Dimming")
                case $selected_value in
                    "1.On")
                        hyprctl keyword decoration:dim_inactive true
                        update_hyprctl_script "decoration:dim_inactive" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "2.Off")
                        hyprctl keyword decoration:dim_inactive false
                        update_hyprctl_script "decoration:dim_inactive" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                        ;;
                    "3.Back")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
            "15. Dimming - Intensity")
                hyprctl keyword decoration:dim_intensity "$selected_value"
                update_hyprctl_script "decoration:dim_intensity" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "16. Opacity (Active Window)")
                hyprctl keyword decoration:opacity_active "$selected_value"
                update_hyprctl_script "decoration:opacity_active" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "17. Opacity (Inactive Window)")
                hyprctl keyword decoration:opacity_inactive "$selected_value"
                update_hyprctl_script "decoration:opacity_inactive" "$selected_value" "$hyprctl_script"
                ~/.config/waybar/hyproptions.sh
                ;;
            "18. X-Ray Effect")
                case $selected_value in
                    "1.On")
                        hyprctl keyword decoration:xray_effect true
                        update_hyprctl_script "decoration:xray_effect" "true" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "2.Off")
                        hyprctl keyword decoration:xray_effect false
                        update_hyprctl_script "decoration:xray_effect" "false" "$hyprctl_script"
                        ~/.config/waybar/hyproptions.sh
                    ;;
                    "3.Back")
                        ~/.config/waybar/hyproptions.sh
                    ;;
                esac
                ;;
        esac
    fi
fi

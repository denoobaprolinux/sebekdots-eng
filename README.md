[(https://raw.githubusercontent.com/stefan-niedermann/paypal-donate-button/master/paypal-donate-button.png)](https://paypal.me/hyprsebek?country.x=TT&locale.x=en_US)

# Sebekdots 3.6-RC1

![Hyprland_2024-10-04_22 37 04](https://github.com/user-attachments/assets/e4a9b4e6-5977-4d52-8d97-0a269abfb666)
_"Powerlink" theme_

![Hyprland_2024-12-31_00 52 22](https://github.com/user-attachments/assets/161ea7b7-769d-4344-a67c-7ab34afac314)
_"Powermix" theme and Waybar Theme Selector_

![Hyprland_2024-12-29_02 49 10](https://github.com/user-attachments/assets/49945283-a1c0-4b19-899f-de502be1b0bb)
_Audio widget_


## Sebekdots, now available in English!

Because it was requested, now I can present to you all my latest work, including an audio widget embedded in Waybar, but made in Eww. I want to keep my setup as functional and lightweight as possible, but without sacrificing its looks.

**Features:**

1. Windows can now be moved with the keyboard.

2. Tab functionality improved, now active tab bars are light indicators and participate in the system color scheme.

3. A window can now be added to a tab group by simply dragging it to the tab group, but it can also be done with keybindings (Control + Super + arrow keys).

4. Bars participate in the Blur effect: if you have a bar with transparency or translucency, and enable the Blur effect in Hyprland's options, the bar also becomes blurred. This gives an additional look and feel to the bars (new themes with this feature have been unintentionally created).

5. Two vertical bars, "Gradient" and "Minimal," have been added, both on the left.

6. Wallpaper selection now it's possible using Waypaper as a front-end, and Hyprpaper configuration is included in this repository. Also, random wallpaper selection can be done with Super + W. Waypaper supports animated wallpapers if you select swww as wallpaper engine.
 
7. Available themes: Powerlink, Powermix, Gradient, Revealers, Minimal, Transparent/Clear and Classic (I started this project with this last one), and by pressing Super + Shift + B or pressing the switch icon in the bar you can select whether if you want them up, down or left (this one as detailed in point 5) Transparent/Clear bars are available in light/dark variants, so you can use them according to the wallpaper you choose.
   
8. There is a file in the Hyprland configurations called custom.conf where you can place your personal configurations. In the update, the file is empty (only with some instructions).

9. The update script detects if Yay, Flatpak, and Snap are installed on the system (Yay must be installed for the dotfiles to work) and asks for confirmation at each step, allowing you to choose not to update items individually. The script also sends notifications about its actions, whether it's the cancellation of the process by the user or the update of items. The update module in Waybar restarts immediately after it finishes executing, resetting to zero as soon as the script execution ends.
   
10. Bars can appear and disappear from the screen to allow for a fullscreen experience. Just press Super + B to toggle the bar on/off.

11. Pressing Super + A shows an on-screen help with all keybindings.

12. There is a "minimize" effect with Super + S, involving a special workspace: you won’t see windows there, they will only be stored and can reappear wherever you want. This can only be done with one window at a time.

13. I have included all the necessary fonts in this repository, so you no longer need to download them. Just clone the repository and follow the Wiki steps to install.

14. If you press both shift keys at the same time, it will change the keyboard layout to Latin American Spanish (useful for those with a different keyboard layout), and each bar has an indicator of the selected language next to the notification center (ESP/ENG). By default, the first layout is English.

15. There's a dedicated button for a clipboard in all bars. It is a front-end for cliphist, so now you have access to a functional clipboard.

16. Pressing Super + Tab you have an overview layout provided by hyprexpo. By default is ready to use in this dotfiles.

![Hyprland_2024-10-06_06 51 43](https://github.com/user-attachments/assets/bc970e03-21a4-4867-a93b-01cae57104c4)
_This is hyprexpo_

## Steps to install Sebekdots

Check the [Wiki](https://github.com/andrewsebek/Sebekdots/wiki)


#!/bin/bash
#var=$(hyprctl activewindow | grep class: | cut -d\  -f2)

if [ $(hyprctl activewindow | grep class: | cut -d\  -f2) == "spotify" ]; then
    hyprctl dispatch movetoworkspacesilent special:spotify
else
    hyprctl dispatch killactive
fi
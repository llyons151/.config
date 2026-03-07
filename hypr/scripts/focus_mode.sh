#!/bin/bash

STATE_FILE="/tmp/hypr_focus_mode"

GAPS_IN=2
GAPS_OUT=2
BORDER=1

if [ -f "$STATE_FILE" ]; then
    # Restore normal layout
    hyprctl keyword general:gaps_in $GAPS_IN
    hyprctl keyword general:gaps_out $GAPS_OUT
    hyprctl keyword general:border_size $BORDER

    # show waybar
    pkill -SIGUSR1 waybar

    rm "$STATE_FILE"
else
    # Enable focus mode
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    hyprctl keyword general:border_size 0

    # hide waybar
    pkill -SIGUSR1 waybar

    touch "$STATE_FILE"
fi

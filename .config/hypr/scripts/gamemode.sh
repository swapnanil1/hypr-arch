#!/usr/bin/env bash

# Script to toggle Hyprland settings for gaming performance

# Define the lock file path
LOCK_FILE="/tmp/hypr_gamemode.lock"

# Check if Game Mode is currently active by checking for the lock file
if [ -f "$LOCK_FILE" ]; then
    # Game Mode is ON - Turn it OFF (Restore default settings)
    echo "Disabling Game Mode..."

    hyprctl --batch "\
        keyword animations:enabled true;\
        keyword decoration:blur:enabled true;\
        keyword decoration:rounding 5;\
        keyword decoration:shadow:enabled false;\
        keyword general:gaps_in 4;\
        keyword general:gaps_out 4;\
        keyword general:border_size 1"

    # Remove the lock file
    rm "$LOCK_FILE"

    # Optional: Notification
    notify-send "Hyprland" "Game Mode: OFF" -u low

else
    # Game Mode is OFF - Turn it ON (Apply performance settings)
    echo "Enabling Game Mode..."

    hyprctl --batch "\
        keyword animations:enabled false;\
        keyword decoration:blur:enabled false;\
        keyword decoration:rounding 0;\
        keyword decoration:shadow:enabled false;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 0"

    # Create the lock file
    touch "$LOCK_FILE"

    # Optional: Notification
    notify-send "Hyprland" "Game Mode: ON" -u low
fi

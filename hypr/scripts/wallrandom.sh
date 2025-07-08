#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Get the active monitor name (first one found)
MONITOR=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Get currently loaded wallpaper path for this monitor
CURRENT_WALL=$(hyprctl hyprpaper listloaded | grep "$MONITOR" | awk '{print $3}')

# Get all wallpapers except the current one
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f ! -path "$CURRENT_WALL"))

# Exit if no alternative wallpapers found
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
  echo "No other wallpapers found."
  exit 1
fi

# Pick a random new wallpaper
NEW_WALLPAPER=$(shuf -e "${WALLPAPERS[@]}" -n 1)

# Apply the new wallpaper
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$NEW_WALLPAPER"
hyprctl hyprpaper wallpaper "$MONITOR,$NEW_WALLPAPER"

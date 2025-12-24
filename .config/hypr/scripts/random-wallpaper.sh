#!/bin/bash

ONE_RANDOM_WALLPAPER=$(find ~/Wallpapers -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)
awww img "$ONE_RANDOM_WALLPAPER"


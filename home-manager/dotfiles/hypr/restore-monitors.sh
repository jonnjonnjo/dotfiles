#!/usr/bin/env bash
STATE=~/.local/share/hypr/monitor-mode
MODE=$(cat "$STATE" 2>/dev/null)

if [ -z "$MODE" ]; then
    grep -q closed /proc/acpi/button/lid/LID/state && MODE=external || MODE=both
fi

mkdir -p ~/.local/share/hypr
echo "$MODE" > "$STATE"

case "$MODE" in
    both)
        hyprctl keyword monitor "eDP-1, 1920x1200@60, 1920x0, 1.333333"
        ;;
    internal)
        hyprctl keyword monitor "eDP-1, 1920x1200@60, 1920x0, 1.333333"
        hyprctl keyword monitor "HDMI-A-1, disable"
        ;;
    external)
        ;;
esac

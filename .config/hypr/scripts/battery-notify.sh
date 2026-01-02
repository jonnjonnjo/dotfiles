#!/bin/bash

BATTERY_PATH="/sys/class/power_supply/BAT0"
CAPACITY=$(cat "$BATTERY_PATH/capacity")
STATUS=$(cat "$BATTERY_PATH/status")

if [ "$STATUS" = "Discharding"]; then 
  if [ "$CAPACITY" -le 5]; then 
    notify-send -u critical "Battery Critical" "Battery at ${CAPACITY}%!"
  elif [ "$CAPACITY" -le 10] then 
    notify-send -u critical "Battery Low" "Battery at ${CAPACITY}%!"
  fi 
fi 

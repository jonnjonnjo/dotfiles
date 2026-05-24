{ pkgs }:
pkgs.writeShellScriptBin "brightness-control" ''
  STATE=/tmp/hypr-brightness
  STEP=5
  CUR=$(cat "$STATE" 2>/dev/null || echo 100)

  case "$1" in
    up)   NEW=$((CUR + STEP)); [ "$NEW" -gt 100 ] && NEW=100 ;;
    down) NEW=$((CUR - STEP)); [ "$NEW" -lt 10  ] && NEW=10  ;;
    *)    echo "usage: brightness-control up|down" >&2; exit 1 ;;
  esac

  echo "$NEW" > "$STATE"
  ${pkgs.hyprland}/bin/hyprctl hyprsunset gamma "$NEW" >/dev/null
''

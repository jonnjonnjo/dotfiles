{ pkgs, ... }:
let
  batteryMonitor = pkgs.writeShellScriptBin "battery-monitor" ''
    set -e
    STATE="/tmp/battery-monitor-state"
    [ -f "$STATE" ] || echo "unset" > "$STATE"

    while true; do
      info=$(${pkgs.acpi}/bin/acpi -b 2>/dev/null)
      if [ -z "$info" ]; then
        sleep 120
        continue
      fi

      pct=$(echo "$info" | grep -oP '\d+(?=%)')
      status=$(echo "$info" | awk -F'[,:]' '{print $2}' | xargs)
      echo "DEBUG: pct=$pct, status=$status" >&2
      prev=$(cat "$STATE")

       if echo "$status" | grep -qi "discharging"; then
         cur="unset"
         [ "$pct" -le 20 ] && cur="20"
         [ "$pct" -le 10 ] && cur="10"
         [ "$pct" -le 5  ] && cur="5"

         if [ "$cur" != "$prev" ]; then
           echo "DEBUG: Notifying for cur=$cur, prev=$prev" >&2
           case "$cur" in
             5)
               ${pkgs.libnotify}/bin/notify-send -u critical -t 0 "Battery Critical" "Battery at $pct% — about to die!" > /dev/null 2>&1
               ;;
             10)
               ${pkgs.libnotify}/bin/notify-send -u critical -t 10000 "Battery Low" "Battery at $pct% — plug in soon!" > /dev/null 2>&1
               ;;
             20)
               ${pkgs.libnotify}/bin/notify-send -u normal -t 5000 "Battery Warning" "Battery at $pct%" > /dev/null 2>&1
               ;;
           esac
           echo "$cur" > "$STATE"
        fi
      else
        [ "$prev" != "unset" ] && echo "unset" > "$STATE"
      fi

      sleep 120
    done
  '';
in
{
  home.packages = [
    batteryMonitor
    pkgs.acpi
    pkgs.libnotify
  ];

  systemd.user.services.battery-monitor = {
    Unit = {
      Description = "Low battery notification monitor";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${batteryMonitor}/bin/battery-monitor";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}

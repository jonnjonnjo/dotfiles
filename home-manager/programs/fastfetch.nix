{ ... }:
let
  esc = builtins.fromJSON ''"\u001b"'';
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = null;
      display = {
        key = {
          type = "both";
          paddingLeft = 2;
          width = 20;
        };
      };
      modules = [
        {
          type = "title";
          format = "|-------------------------------------------------------|${esc}[40D: {#1}{user-name} @ {host-name}{#} :";
        }
        {
          type = "Host";
          key = "Host";
          keyColor = "magenta";
        }
        {
          type = "command";
          key = "Age";
          keyColor = "magenta";
          text = ''
            read by bm bd <<< $(echo "2003 11 03")
            read ty tm td <<< $(date "+%Y %m %d")
            years=$((ty - by)); months=$((tm - bm)); days=$((td - bd))
            if [ $days -lt 0 ]; then months=$((months - 1)); prev=$(date -d "$ty-$tm-01 -1 day" +%d); days=$((days + prev)); fi
            if [ $months -lt 0 ]; then years=$((years - 1)); months=$((months + 12)); fi
            total=$(( ($(date +%s) - $(date -d "2003-11-03" +%s)) / 86400 ))
            printf "%02d-%02d-%02d (%d)\n" $years $months $days $total
          '';
        }
        {
          type = "cpuusage";
          key = "CPU Usage";
          keyColor = "magenta";
          format = "{1}";
        }
        {
          type = "memory";
          key = "Memory";
          keyColor = "magenta";
        }
        {
          type = "brightness";
          key = "Brightness";
          keyColor = "magenta";
        }
        {
          type = "battery";
          key = "Battery";
          keyColor = "red";
          format = "{capacity} [{status}]";
        }
        {
          type = "datetime";
          key = "Date & Time";
          keyColor = "blue";
        }
        {
          type = "uptime";
          key = "Uptime";
          keyColor = "blue";
        }
        {
          type = "DNS";
          key = "DNS";
          keyColor = "cyan";
        }
        {
          type = "localip";
          key = "Local IP";
          keyColor = "cyan";
          compact = true;
        }
        {
          type = "publicip";
          key = "Public IP";
          keyColor = "cyan";
        }
        {
          type = "wifi";
          key = "Wifi";
          keyColor = "cyan";
          format = "{ssid} ({signal-quality})";
        }
        {
          type = "traffic";
          key = "Traffic";
          keyColor = "cyan";
          interface = "wlan0";
        }
        {
          type = "Weather";
          key = "Weather";
          keyColor = "green";
        }
        {
          type = "sound";
          key = "Sound";
          keyColor = "yellow";
        }
        {
          type = "custom";
          keyIcon = "";
          key = "Disks";
        }
        {
          type = "disk";
          key = " ";
          format = "        [{mountpoint}] - {size-used} / {size-total} ({size-percentage})";
        }
        "break"
      ];
    };
  };
}

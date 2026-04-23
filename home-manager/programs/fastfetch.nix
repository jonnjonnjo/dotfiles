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
          type        = "both";
          paddingLeft = 2;
          width       = 20;
        };
      };
      modules = [
        {
          type   = "title";
          format = "|-------------------------------------------------------|${esc}[40D: {#1}{user-name} @ {host-name}{#} :";
        }
        { type = "Host";       key = "Host";       keyColor = "magenta"; }
        { type = "cpuusage";   key = "CPU Usage";  keyColor = "magenta"; format = "{1}"; }
        { type = "memory";     key = "Memory";     keyColor = "magenta"; }
        { type = "brightness"; key = "Brightness"; keyColor = "magenta"; }
        { type = "battery";    key = "Battery";    keyColor = "red";     format = "{capacity} [{status}]"; }
        { type = "datetime";   key = "Date & Time"; keyColor = "blue"; }
        { type = "uptime";     key = "Uptime";     keyColor = "blue"; }
        { type = "DNS";        key = "DNS";        keyColor = "cyan"; }
        { type = "localip";    key = "Local IP";   keyColor = "cyan"; compact = true; }
        { type = "publicip";   key = "Public IP";  keyColor = "cyan"; }
        { type = "wifi";       key = "Wifi";       keyColor = "cyan"; format = "{ssid} ({signal-quality})"; }
        { type = "traffic";    key = "Traffic";    keyColor = "cyan"; interface = "wlan0"; }
        { type = "Weather";    key = "Weather";    keyColor = "green"; }
        { type = "sound";      key = "Sound";      keyColor = "yellow"; }
        {
          type    = "custom";
          keyIcon = "";
          key     = "Disks";
        }
        {
          type   = "disk";
          key    = " ";
          format = "        [{mountpoint}] - {size-used} / {size-total} ({size-percentage})";
        }
        "break"
      ];
    };
  };
}

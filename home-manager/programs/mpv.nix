{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.uosc ];
    scriptOpts = {
      uosc = {
        # https://simplelocalize.io/data/locales/
        languages = "zh-CN,en";
        # languages = "pt-PT";
      };
    };
    config = {
      sub-font = "IBM Plex Sans";
    };
    bindings = {
      "ctrl+alt+a" = "script-binding uosc/audio";
      "ctrl+alt+s" = "script-binding uosc/load-subtitles";
      "ctrl+alt+d" = "script-binding uosc/download-subtitles";
      "ctrl+alt+p" = "script-binding print-hello";
      "ctrl+alt+f" = "script-binding randomized-font";
      "ctrl+alt+F" = "script-binding select-font";
    };
  };

  xdg.configFile."mpv/scripts/mpv-font-picker.lua".source = ./mpv-font-picker.lua;
}

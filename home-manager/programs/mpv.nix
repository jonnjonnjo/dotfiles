{pkgs,...}:
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
    bindings = {
      "ctrl+alt+a" = "script-binding uosc/audio";
      "ctrl+alt+s" = "script-binding uosc/load-subtitles";
      "ctrl+alt+d" = "script-binding uosc/download-subtitles";
      # "ctrl+alt+f" = "script-binding mpv-font-picker/print-hello";
      "ctrl+alt+f" = "script-binding print-hello";
      "ctrl+alt+F" = "script-binding get_system_fonts";
    };
  };

  xdg.configFile."mpv/scripts/mpv-font-picker.lua".source = ./mpv-font-picker.lua;

}

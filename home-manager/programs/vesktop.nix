{...}: {
  programs.vesktop = {
    enable = true;
    vencord.themes = {
      "rose-pine" = ''
        @import url("https://raw.githubusercontent.com/rose-pine/discord/main/dist/rose-pine-dawn.css");
      '';
    };
    vencord.settings.enabledThemes = ["rose-pine.css"];
  };
}

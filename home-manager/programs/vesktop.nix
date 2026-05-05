{inputs,...}:
{
  programs.vesktop = {
    enable = true;
    vencord.themes = {
      "ClearVision.css" = builtins.readFile "${inputs.clearvision}/ClearVision_v6.theme.css";
    };
    # vencord.themes = {
    #   "ClearVision.css" = builtins.fetchurl {
    #     url = "https://raw.githubusercontent.com/ClearVision/ClearVision-v6/master/ClearVision_v6.theme.css";
    #     sha256 = ""; # run: nix-prefetch-url <url> to fill this in
    #   };
    # };
    # vencord.settings.enabledThemes = [ "ClearVision.css" ];
  };
}

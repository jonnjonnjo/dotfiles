{...}:
{
  programs.kitty = {
    enable = true;
    extraConfig = "include current-theme.conf";
    settings = {
      dynamic_background_opacity = "yes";
      background_opacity = "0.80";
      window_padding_width = "8 10";
      tab_title_max_length = 25;
      tab_title_template = "{title}";
    };
    keybindings = {
      "super+equal" = "set_background_opacity +0.1";
      "super+minus" = "set_background_opacity -0.1";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+n" = "new_tab_with_cwd";
    };
  };
}

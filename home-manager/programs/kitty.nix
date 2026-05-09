{...}: {
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

      # Swap tabs like Firefox (ctrl+shift+pgup/pgdown)
      "ctrl+shift+page_up" = "move_tab_forward";
      "ctrl+shift+page_down" = "move_tab_backward";

      # Jump directly to tab by index
      "ctrl+1" = "goto_tab 1";
      "ctrl+2" = "goto_tab 2";
      "ctrl+3" = "goto_tab 3";
      "ctrl+4" = "goto_tab 4";
      "ctrl+5" = "goto_tab 5";
      "ctrl+6" = "goto_tab 6";
      "ctrl+7" = "goto_tab 7";
      "ctrl+8" = "goto_tab 8";
      "ctrl+9" = "goto_tab 9";
    };
  };
}

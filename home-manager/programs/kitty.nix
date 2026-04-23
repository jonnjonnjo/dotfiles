{...}:
{
  programs.kitty = {
    enable = true;
    extraConfig = "include current-theme.conf";
    settings = {
      window_padding_width = "8 10";
      tab_title_max_length = 25;
      tab_title_template = "{title}";
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+n" = "new_tab_with_cwd";
    };
  };
}

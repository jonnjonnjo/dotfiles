{ ... }:
{
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      default-timeout = 5000;
      max-visible = 5;
      # Align with Hyprland's rounding = 0 for sharp corners
      border-radius = 0;
      # Catppuccin Mocha Yellow for accent
      border-color = "#e6b91e"; # This is close to Catppuccin Mocha Yellow, matching your amber cursor.
      # Catppuccin Mocha Base
      background-color = "#1e1e2e";
      # Catppuccin Mocha Text
      text-color = "#cdd6f4";
      width = 350;
      padding = 12;
      group-by = "summary";
      sort = "-time";
      # Using Iosevka as per your Kitty config, falling back to Sans if not available
      font = "Iosevka 11";
    };
  };
}

{ config, pkgs, ... }:
{
  services.displayManager.ly = {
    enable = true;
    settings = {
# edit this if you are not deppressed 
      animation ="colormix";
      clock = "%c";
      bigclock = false;
      margin_box_h = 2;
      margin_box_v = 1;
      vi_mode = false;
    };
  };

  }

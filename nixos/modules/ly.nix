{ config, pkgs, ... }:
{
  services.displayManager.ly = {
    enable = true;
    settings = {
      # animation ="dur_file";
      # dur_file_path =  "/home/jon/Downloads/blackhole-smooth-240x67.dur";
      dur_offset_alignment = "center";
      asterisk = null; 
      auth_fails = 10; 
      clock = "%c";
      clear_password = true;
      bigclock = false;
      full_color = 1;
      margin_box_h = 2;
      margin_box_v = 1;
      text_in_center = true; 
      vi_mode = false;


      # for game of life 
      animation = "gameoflife";
      gameoflife_entropy_interval = 10;
      # gameoflife_fg = 0x0000FF00;
      gameoflife_frame_delay = 1;
      gameoflife_initial_density = 0.8;

    };
  };

  }

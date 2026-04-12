{ config,awww,  lobster,pkgs, ... }:

let 
  randomWallpaper = import ./scripts/wallpaper.nix {inherit pkgs;};

  # myMpv = config.programs.mpv.finalPackage;
  # lobster-custom = lobster.packages.${pkgs.system}.default.override {
  #   mpv = myMpv;
  # };
in
{
  imports = [
    ./nixvim.nix

  ];
  home.username = "jon";
  home.homeDirectory = "/home/jon";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    awww.packages.${pkgs.system}.default
    (lobster.packages.${pkgs.system}.default.override{
	mpv = config.programs.mpv.finalPackage;
    })
    yt-dlp
    aria2
    ffmpeg
    zoom-us
    randomWallpaper
    fastfetch
    gnumake
    nodejs 
    yarn
    whois
    vim
    wget
    firefox
    gh
    grim
    slurp
    wl-clipboard
    kitty
    git
    wireguard-tools
    gcc
    wev
    zathura
    rclone
    powerline
    hyprlock
    unzip
    hypridle
    zinit
    
    (writeShellScriptBin "f-g" ''
      firefox -P "f-g" --no-remote &
    '')
    

    (writeShellScriptBin "f-o" ''
      firefox -P "f-o" --no-remote &
    '')
  ];


  home.file = {
    ".config/lobster" = {
        source = ./dotfiles/lobster;
        recursive  = true;
      };
    ".config/hypr"  = {
        source = ./dotfiles/hypr;
        recursive = true;
      }; 

    ".config/kitty"  = {
        source = ./dotfiles/kitty;
        recursive = true;
      }; 

    ".config/tofi"  = {
        source = ./dotfiles/tofi;
        recursive = true;
      }; 
    ".config/fastfetch"  = {
        source = ./dotfiles/fastfetch;
        recursive = true;
      }; 

    ".config/zsh" = {
        source = ./dotfiles/zsh;
        recursive = true;
      };
  };

  home.sessionVariables = {
    EDITOR="nvim";
  };

  home.pointerCursor = {
    gtk.enable = true;
    hyprcursor.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 24;
  };
	

  programs.home-manager.enable = true;
  programs.tofi.enable = true;
  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.uosc ];
    config = {
      vo = "gpu-next";
      gpu-api = "vulkan";
      hwdec = "vaapi";
      hwdec-codecs = "all";
      # ADD THIS LINE:
      target-colorspace-hint = "no"; # Fixes the fullscreen washout
    };
  };
  programs.zsh = {
    enable = true;
    initExtra = ''
      source ${pkgs.zinit}/share/zinit/zinit.zsh
      source ~/.config/zsh/.zshrc
    '';
  };
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      format = "$directory$git_branch$git_status$cmd_duration$character";

      directory = {
        truncation_length = 1;
        truncate_to_repo = false;
      };

      git_branch = {
        format = "[$branch]($style) ";
        style = "cyan";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "red";
      };

      cmd_duration = {
        min_time = 2000;
        format = "[ $duration]($style) ";
        style = "yellow";
      };

      character = {
        success_symbol = "[>](green)";
        error_symbol = "[>](red)";
      };
    };
  };
  
  services.hyprsunset.enable=true;
}

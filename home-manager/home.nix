{ config,awww, lib, pkgs, ... }:

let 
  randomWallpaper = import ./scripts/wallpaper.nix {inherit pkgs;};
  opacityUp       = import ./scripts/opacity-up.nix {inherit pkgs;};
  opacityDown = import ./scripts/opacity-down.nix {inherit pkgs;};
in
{
  imports = [
    ./nixvim.nix

  ];

  home.activation = {
    createNvimUndoDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ${config.home.homeDirectory}/.local/state/nvim/undo
    '';
  };
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
    poppler-utils
    google-chrome
    ranger
    yt-dlp
    pass
    pinentry-curses 
    aria2
    nsxiv
    jpegoptim
    ani-cli
    ffmpeg
    ripgrep
    zoom-us
    randomWallpaper
    opacityUp  
    opacityDown
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

  };

  home.sessionVariables = {
    QT_SCALE_FACTOR = "1.5";
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
    bindings = {
      "ctrl+alt+s" = "script-binding uosc/load-subtitles";
      "ctrl+alt+d" = "script-binding uosc/download-subtitles";
    };
  };

  xdg.configFile."mpv/mpv.conf".text = ''
    vo=gpu-next
    gpu-api=vulkan
    target-colorspace-hint=no
    hwdec=vaapi
  '';

  programs.zsh = {
    enable = true;
    
  };

  programs.starship = {
    enable = true;
  };
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
  };
  programs.gpg = {
    enable = true;
  };
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.my-vault";
    };
  };
  
  services.hyprsunset.enable=true;
}

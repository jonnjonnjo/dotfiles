{ config,awww, pkgs, ... }:

let 
  randomWallpaper = import ./scripts/wallpaper.nix {inherit pkgs;};
in
{
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
    randomWallpaper
    fastfetch
    neovim
    vim
    wget
    firefox
    gh
    mpv
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

    ".config/nvim"  = {
        source = ./dotfiles/nvim;
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
    EDITOR="nvim";
  };

  programs.home-manager.enable = true;
  programs.tofi.enable = true;
  
  services.hyprsunset.enable=true;
}

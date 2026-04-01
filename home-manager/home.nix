{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
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
  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # pain files is through 'home.file'.
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
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR="nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

{ config,awww, lib, pkgs, ... }:

let 
  randomWallpaper = import ./scripts/wallpaper.nix {inherit pkgs;};
in
{
  imports = [
    ./programs/zsh.nix
    ./programs/tofi.nix
    ./programs/kitty.nix
    ./programs/fastfetch.nix
    ./programs/nixvim.nix
    ./programs/file-explorer.nix
  ];

  home.activation = {
    createNvimUndoDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ${config.home.homeDirectory}/.local/state/nvim/undo
    '';
  };
  home.username = "jon";
  home.homeDirectory = "/home/jon";

  home.packages = with pkgs; [
    openssl.dev
    pkg-config
    zlib
    libiconv
    libxml2
    libxslt
    readline
    ncurses
    glibc
    stdenv.cc.cc.lib
    cairo
    pango
    libpng
    libjpeg
    libwebp
    freetype
    fontconfig
    alsa-lib
    pulseaudio
    libGL
    libx11
    libxext
    libxrandr
    libxi
    libxcursor
    libxinerama
    dbus
    glib
    gtk3
    gtk4
    libffi
    libuuid
    libsodium
    libgit2
    libusb1
    libudev-zero
    curl.dev
    sqlite.dev
    pcre
    pcre2
    expat
    bzip2
    xz
    lz4
    zstd
    grpc
    protobuf
    buf
    evans
    k9s
    helm
    minikube
    flyctl
    railway
    awscli2
    turso
    godot_4
    SDL2
    SDL2_image
    SDL2_mixer
    SDL2_ttf
    sfml
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    libGL
    mesa
    glfw
    glm
    assimp
    inkscape
    gimp
    krita
    blender
    obs-studio
    darktable
    rawtherapee
    audacity
    vlc
    python3
    uv
    rustup
    go
    jdk
    lua
    ruby
    php
    dotnet-sdk
    bun
    deno
    postgresql
    sqlite
    mysql84
    redis
    dbeaver-bin
    jq
    yq
    curl
    httpie
    docker
    docker-compose
    kubectl
    terraform
    ansible
    git-lfs
    lazygit
    tmux
    fzf
    bat
    eza
    fd
    delta
    hyperfine
    tokei
    direnv
    strace
    nmap
    cmake
    pkg-config
    meson
    ninja
    zoxide
    rsync
    btop
    ncdu
    tree
    imagemagick
    pandoc
    tesseract
    qrencode
    socat
    openssl
    age
    sops
    tldr
    stremio-linux-shell
    usbutils 
    android-tools
    claude-code
    kdePackages.libkscreen  
    wlr-randr        
    typescript
    awww.packages.${pkgs.system}.default
    typst
    poppler-utils
    google-chrome
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

  };

  home.sessionVariables = {
    QT_SCALE_FACTOR = "1.5";
    EDITOR="nvim";
    ANDROID_HOME="$HOME/Android/Sdk";
  };

  home.pointerCursor = {
    gtk.enable = true;
    hyprcursor.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 24;
  };
	

  programs.home-manager.enable = true;

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

  home.file.".clang-format".text = ''
    BasedOnStyle: LLVM
    ColumnLimit: 80
    AllowShortFunctionsOnASingleLine: None
    AllowShortBlocksOnASingleLine: Never
    AllowShortIfStatementsOnASingleLine: Never
    AllowShortLoopsOnASingleLine: false
  '';


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
  services.udiskie = {
    enable = true;
    automount = true;
  };


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
}


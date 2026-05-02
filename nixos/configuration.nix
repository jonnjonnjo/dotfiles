{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/ly.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.kernelModules = [ "kvm-amd" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # for kernel level fix on coloring
  boot.kernelParams = [ 
    "vt.default_red=0,0,0,0,0,0,0,0"
    "video=HDMI-A-1:1920x1080@60"
  ];

  networking.hostName = "jon-nixos"; 
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Jakarta";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  i18n = {
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        fcitx5-gtk
      ];
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      vulkan-loader
      vulkan-validation-layers
    ];
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    enable = true;
    packages = [ pkgs.terminus_font ];
    font = "ter-v18n";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.udisks2.enable = true;
  services.pcscd.enable = true;
  services.gvfs.enable = true;

  services.syncthing = {
    enable = true;
    user = "jon";
    dataDir = "/home/jon";
    openDefaultPorts = true;
  };
  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };
  users.users.jon = {
    isNormalUser = true;
    description = "";
    extraGroups = [
      "adbusers"
      "kvm"
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  users.defaultUserShell =pkgs.zsh;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
   android-studio
   jdk17
   jmtpfs
   texlive.combined.scheme-full
   brightnessctl
   hypridle
   hyprsunset
   hyprcursor
  ];


  fonts.fontconfig.defaultFonts.sansSerif = [ "Noto Sans CJK SC" ];
  fonts.packages = with pkgs; [
    ibm-plex
    noto-fonts-cjk-serif-static
    noto-fonts-cjk-serif
    arphic-ukai
    source-han-serif
    noto-fonts-cjk-sans-static
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    source-sans-pro
    cm_unicode
    barlow
    linux-libertine-g
    libertine
    iosevka
    fira-mono
    libertinus
    newcomputermodern
    dejavu_fonts
    source-serif-pro
    fira-code
    roboto
    lato
    ubuntu-classic
    inter
    inconsolata
    gyre-fonts
    xits-math
    source-code-pro
    liberation_ttf
    cascadia-code
    julia-mono
    recursive
    font-awesome
    hack-font
    victor-mono
    monaspace
    jetbrains-mono
    wqy_zenhei
    wqy_microhei
    hanazono
    lxgw-wenkai
    source-han-sans-vf-ttf
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.noto
    eb-garamond
    gentium-plus
    unifont
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-runtime"
    "android-studio"
    "zoom"
    "google-chrome"
  ];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}


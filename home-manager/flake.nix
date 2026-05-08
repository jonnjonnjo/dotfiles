{
  description = "Home Manager configuration of jon";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awww = {
        url="git+https://codeberg.org/LGFae/awww";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, awww, nixvim, ... }:
    let
      system = "x86_64-linux";
      # pkgs = import nixpkgs {
      #   inherit system;
      #   config.allowUnfreePredicate = pkg: builtins.elem pkg.pname [
      #     "zoom-us"
      #   ];
      # };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations."jon" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ 
          ./home.nix 
          nixvim.homeModules.nixvim

        ];

        extraSpecialArgs = { inherit awww; };
      };
    };
}

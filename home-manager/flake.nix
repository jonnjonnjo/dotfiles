{
  description = "Home Manager configuration of jon";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jzw = {
      url = "github:jonnjonnjo/kmp-zhongwen-fanyi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      awww,
      jzw,
      nixvim,
      pre-commit-hooks,
      ...
    }:
    let
      system = "x86_64-linux";
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

        extraSpecialArgs = { inherit awww jzw; };
      };

      checks.x86_64-linux.pre-commit-check = pre-commit-hooks.lib.x86_64-linux.run {
        src = ./.;
        hooks = {
          nixfmt-rfc-style.enable = true;
          deadnix.enable = true;
        };
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        inherit (self.checks.x86_64-linux.pre-commit-check) shellHook;
        buildInputs = self.checks.x86_64-linux.pre-commit-check.enabledPackages;
      };
    };
}

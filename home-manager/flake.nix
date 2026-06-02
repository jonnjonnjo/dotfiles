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
    claude-code-nix.url = "github:sadjow/claude-code-nix";
    jzw = {
      url = "github:jonnjonnjo/kmp-zhongwen-fanyi/main";
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
      claude-code-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "google-chrome"
            "zoom"
            "dbeaver"
            "telegram-desktop"
            "karere"
            "claude-code"
          ];
        overlays = [ claude-code-nix.overlays.default ];
      };
    in
    {
      homeConfigurations."jon" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          nixvim.homeModules.nixvim
          { programs.nixvim.nixpkgs.source = nixpkgs; }
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

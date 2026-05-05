{
  description = "System configuration for jon-nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    claude-code-nix.url = "github:sadjow/claude-code-nix";
    clearvision = {
      url = "github:ClearVision/ClearVision-v6";
      flake = false;
    };
  };

  outputs = { self, nixpkgs,home-manager,claude-code-nix, ... }@inputs: {
    nixosConfigurations = {
      "jon-nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
        specialArgs = { inherit inputs; };
        
        modules = [
          ./configuration.nix
        ];
      };
    };
    homeConfigurations."yourusername" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        {
          nixpkgs.overlays = [ claude-code-nix.overlays.default ];
        }
        ./home.nix
      ];
    };
  };
}

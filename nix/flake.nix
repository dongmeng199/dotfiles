{
  description = "my nix config";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs:
  let
    inherit (darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs-unstable.lib) attrValues makeOverridable optionalAttrs singleton;

    # Configuration for `nixpkgs`
    nixpkgsConfig = {
      config = { allowUnfree = true; };
    };
  in
  {
    # `nix-darwin` configs
    darwinConfigurations = rec {
      # mbp2015： 主机名
      mac-mini = darwinSystem {
        # x86_64： CPU 架构
        system = "aarch64-darwin";
        modules = [
          ./config.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dongmeng = import ./home-manager/home.nix;
          }
        ];
      };
      macbook = darwinSystem {
        # x86_64： CPU 架构
        system = "aarch64-darwin";
        modules = [
          ./config.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."meng.dong" = import ./home-manager/home.nix;
          }
        ];
      };
    };

    overlays = {
    };
  };
}

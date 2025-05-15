# flake.nix
{
  description = "Simple Nix-Darwin system with NixOS and Homebrew integration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.url = "git+https://github.com/zhaofengli/nix-homebrew?ref=refs/pull/71/merge";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    home-manager,
  }: let
    user = "smchunn";
    host = "mini";
    platform = "aarch64-darwin";
    iosevka-sc = nixpkgs.legacyPackages.${platform}.iosevka.override {
      set = "-sc";
      privateBuildPlan = {
        family = "iosevka-sc";
        spacing = "term";
        serifs = "sans";
        noCvSs = true;
        exportGlyhNames = false;
        noLigation = true;

        weights = {
          Light = {
            shape = 300;
            menu = 300;
            css = 300;
          };
          Regular = {
            shape = 400;
            menu = 400;
            css = 400;
          };
          Bold = {
            shape = 700;
            menu = 700;
            css = 700;
          };
        };
      };
    };
    iosevka-scnf = nixpkgs.legacyPackages.${platform}.callPackage ./iosevka-nf.nix {
      inherit iosevka-sc;
    };
  in {
    darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
      system = platform;
      specialArgs = {inherit self iosevka-scnf user host platform;};
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = user;
          };
        }
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.extraSpecialArgs = {inherit user host;};
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = import ./home.nix;
        }
      ];
    };
  };
}

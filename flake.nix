# flake.nix
{
  description = "Simple Nix-Darwin system with NixOS and Homebrew integration";

  inputs = {
    # macOS: use the darwin-scoped Nixpkgs branch matching nix-darwin 25.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    # nix-darwin (25.05) must follow the same nixpkgs
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # nix-homebrew — do NOT override its inputs (they vary by version)
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    ...
  }: let
    user = "smchunn";
    host = "mini";
    platform = "aarch64-darwin";
  in {
    darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
      system = platform;
      specialArgs = {
        inherit
          self
          user
          host
          platform
          ;
      };
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = user;
          };
          system.primaryUser = user;
        }
        ./darwin.nix
      ];
    };
  };
}

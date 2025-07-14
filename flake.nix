{
  description = "Home Manager flake config for nix-on-droid phones";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-linux";

      mkHome = filePath:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [
            ./phones/common.nix
            (import filePath)
          ];
        };
    in {
      homeConfigurations = {
        n5x    = mkHome ./phones/n5x.nix;
        p1xl   = mkHome ./phones/p1xl.nix;
        p3axl  = mkHome ./phones/p3axl.nix;
        p6pro  = mkHome ./phones/p6pro.nix;
      };
    };
}

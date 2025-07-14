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
      mkHome = name: file: home-manager.lib.homeManagerConfiguration {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
        modules = [ ./phones/common.nix file ];
      };
    in {
      homeConfigurations = {
        n5x    = mkHome "n5x"    ./phones/n5x.nix;
        p1xl   = mkHome "p1xl"   ./phones/p1xl.nix;
        p3axl  = mkHome "p3axl"  ./phones/p3axl.nix;
        p6pro  = mkHome "p6pro"  ./phones/p6pro.nix;
      };
    };
}

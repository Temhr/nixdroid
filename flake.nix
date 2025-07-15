{
  description = "flake config for nix-on-droid phones";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  
  outputs = { self, nixpkgs, home-manager, nix-on-droid, ... }:
    let
      system = "aarch64-linux";
      
      # Helper function for home-manager configurations
      mkHome = filePath:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [
            ./homes/common.nix
            (import filePath)
          ];
        };
      
      # Helper function for nix-on-droid configurations with integrated home-manager
      mkNixOnDroid = deviceConfig: deviceName:
        nix-on-droid.lib.nixOnDroidConfiguration {
          modules = [
            ./systems/common.nix
            deviceConfig
            
            # Integrate home-manager into nix-on-droid
            {
              home-manager = {
                config = ./homes/common.nix;
                backupFileExtension = "hm-backup";
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  # Pass any extra args to home-manager modules
                };
              };
            }
            
            # Device-specific home-manager config
            {
              home-manager.config = ./homes/${deviceName}.nix;
            }
            
            # list of extra modules for Nix-on-Droid system
            # { nix.registry.nixpkgs.flake = nixpkgs; }
            # ./path/to/module.nix
            # or import source out-of-tree modules like:
            # flake.nixOnDroidModules.module
          ];
          # list of extra special args for Nix-on-Droid modules
          extraSpecialArgs = {
            # rootPath = ./.;
          };
          # set nixpkgs instance, it is recommended to apply `nix-on-droid.overlays.default`
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            overlays = [
              nix-on-droid.overlays.default
              # add other overlays
            ];
          };
          # set path to home-manager flake
          home-manager-path = home-manager.outPath;
        };
    in {
      # Nix-on-Droid system configurations with integrated home-manager
      nixOnDroidConfigurations = {
        default = mkNixOnDroid ./systems/default.nix "default";
        n5x     = mkNixOnDroid ./systems/n5x.nix "n5x";
        p1xl    = mkNixOnDroid ./systems/p1xl.nix "p1xl";
        p3axl   = mkNixOnDroid ./systems/p3axl.nix "p3axl";
        p6pro   = mkNixOnDroid ./systems/p6pro.nix "p6pro";
      };
      
      # Optional: Standalone Home Manager configurations (if needed for testing)
      # homeConfigurations = {
      #   n5x   = mkHome ./homes/n5x.nix;
      #   p1xl  = mkHome ./homes/p1xl.nix;
      #   p3axl = mkHome ./homes/p3axl.nix;
      #   p6pro = mkHome ./homes/p6pro.nix;
      # };
    };
}

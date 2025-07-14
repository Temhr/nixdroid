{ pkgs, ... }: {

  # Optional: add or override device-specific packages
  home.packages = with pkgs; [
    # pkgs specific to this phone 
    # (you can add nothing here and inherit all from common.nix)
  ];
}

{ config, lib, pkgs, ... }: {

  # Simply install just the packages
  environment.packages = with pkgs; [
    obs-studio
  ];

  programs.obs-studio = {
          enable = true;
  };

}

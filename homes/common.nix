{ config, lib, pkgs, ... }: {

  # Read the changelog before changing this value
  home.stateVersion = "24.05";

  # Shared packages for all devices
  home.packages = with pkgs; [
    bat         # cat with syntax highlighting
    curl        # Command-line HTTP client
    fastfetch   # System info display
    fd          # Simple find alternative
    git         # Version control
    nano        # Terminal text editor
    htop        # Interactive system monitor
    ripgrep     # Fast recursive search
    starship    # Shell prompt

    ncdu        # Disk usage tool
    tree        # Directory tree

    fzf         # Fuzzy finder
    tldr        # Short man pages

    mosh        # Mobile shell (ssh replacement)
    openssh     # ssh/scp/sftp
    sshfs       # allows remote filesystems to be mounted over SSH

    figlet cowsay lolcat  # fun
  ];

  # Bash shell configuration
  programs.bash = {
    enable = true;

    # Declare useful shell aliases
    shellAliases = {
      "ll" = "ls -alF";
      "gs" = "git status";
      ".." = "cd ..";
      "..." = "cd ../..";
      "grep" = "grep --color=auto";
      "switch" = "cd ~/nixdroid && git pull && nix-on-droid switch --flake ."
    };

    # Extra lines to inject into .bashrc
    initExtra = ''
      export PATH="$HOME/.nix-profile/bin:$PATH"

      # Display system info at login
      fastfetch

      # Optional: Enable color support for ls and grep
      if [ -x /usr/bin/dircolors ]; then
        eval "$(dircolors -b)"
      fi
    '';
  };

  # Enable starship prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
}

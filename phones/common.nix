{ pkgs, ... }: {

  # Shared user identity for nix-on-droid
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "25.05";

  # Shared packages for all devices
  home.packages = with pkgs; [
    bat         # cat with syntax highlighting
    curl        # Command-line HTTP client
    fastfetch   # Terminal text editor
    fd          # Simple find alternative
    git         # Version control
    htop        # Interactive system monitor
    ripgrep     # Fast recursive search
    starship    # Shell prompt

    ncdu        # Disk usage tool
    tree        # Directory tree

    fzf         # Fuzzy finder
    tldr        # Short man pages

    mosh        # Mobile SSH
    openssh     # ssh/scp/sftp

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

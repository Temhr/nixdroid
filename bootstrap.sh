#!/usr/bin/env bash
set -euo pipefail

# Bootstrap Home Manager configuration for nix-on-droid

# Default values
REPO_URL="https://github.com/Temhr/nixdroid"
CLONE_DIR="$HOME/nixdroid"

# Attempt to detect phone identity
detect_device() {
  local model
  model=$(getprop ro.product.model | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

  case "$model" in
    *pixel3a*)  echo "p3axl" ;;
    *pixel6pro*) echo "p6pro" ;;
    *pixelxl*)   echo "p1xl" ;;
    *nexus5x*)   echo "n5x" ;;
    *)
      echo "unknown"
      return 1
      ;;
  esac
}

# Ensure git and nix are available
require_tools() {
  command -v git >/dev/null 2>&1 || {
    echo "❌ Git is not installed. Install it using nix-on-droid or pkg."
    exit 1
  }
  command -v nix >/dev/null 2>&1 || {
    echo "❌ Nix is not available. Are you inside nix-on-droid?"
    exit 1
  }
}

# Clone config if it doesn't exist
clone_repo() {
  if [ ! -d "$CLONE_DIR" ]; then
    echo "📥 Cloning nix config from $REPO_URL"
    git clone "$REPO_URL" "$CLONE_DIR"
  else
    echo "📂 Using existing nix config in $CLONE_DIR"
  fi
}

# Run the correct homeManagerConfiguration
apply_config() {
  local device=$1
  echo "📦 Applying Home Manager config for: $device"
  cd "$CLONE_DIR"
  nix run ".#homeConfigurations.${device}.activationPackage"
}

main() {
  require_tools
  clone_repo

  echo "🔍 Detecting device..."
  if ! device=$(detect_device); then
    echo "❌ Could not auto-detect your device model."
    echo "   Please run this manually with one of:"
    echo "     nix run .#homeConfigurations.p3axl.activationPackage"
    echo "     nix run .#homeConfigurations.p6pro.activationPackage"
    echo "     nix run .#homeConfigurations.p1xl.activationPackage"
    echo "     nix run .#homeConfigurations.n5x.activationPackage"
    exit 1
  fi

  apply_config "$device"
  echo "✅ Setup complete!"
}

main "$@"

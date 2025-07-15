# Nixdroid

My implementation of [nix-on-droid](https://github.com/nix-community/nix-on-droid) for my varous android phones.

# Implementations
<details>
<summary>Instalation directions and update commands <i>(click to expand)</i></summary>
<p></p>

- **Installation**:
  1) Install nix-on-droid, with flakes enabled
  2) Start a shell with git `nix shell nixpkgs#git`
  3) Clone repo `git clone https://github.com/Temhr/nixdroid`
  4) `cd nixdroid` and `nix-on-droid switch --flake .#{device}`
- Updating systems imperatively:
  - `nix-on-droid switch --flake ./nixdroid`
</details>

# Repository Layout

- **homes/**: home configs
  - **common.nix**: shared
  - **n5x.nix**: device-specific
  - **p1xl.nix**: device-specific
  - **p3axl.nix**: device-specific
  - **p6pro.nix**: device-specific
- **systems/**: system configs
  - **common.nix**: shared
  - **n5x.nix**: device-specific
  - **p1xl.nix**: device-specific
  - **p3axl.nix**: device-specific
  - **p6pro.nix**: device-specific
- **flake.nix**

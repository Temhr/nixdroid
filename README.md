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
├── flake.nix
├── homes/
│   ├── common.nix      # Shared home config
│   ├── n5x.nix         # Device-specific config
│   ├── p1xl.nix        # Device-specific config  
│   ├── p3axl.nix       # Device-specific config
│   └── p6pro.nix       # Device-specific config
└── systems/
    ├── common.nix      # Shared system config
    ├── n5x.nix         # Device-specific config
    ├── p1xl.nix        # Device-specific config
    ├── p3axl.nix       # Device-specific config
    └── p6pro.nix       # Device-specific config

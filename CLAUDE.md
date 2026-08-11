# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Nix flake managing NixOS system configuration and home-manager user environments across four hosts from a single repo.

## Common Commands

```bash
# Format all Nix files
nix fmt

# Build & switch home-manager (from repo root)
home-manager switch --flake .#rohit@ubuntu-wsl
home-manager switch --flake .#rohits@hp15seq
home-manager switch --flake .#rohit@opensuse-hp
home-manager switch --flake .#rohit@fedora
home-manager switch --flake .#azureuser@scripts-vm

# Rebuild NixOS system (hp15seq only)
sudo nixos-rebuild switch --flake .#hp15seq

# Update flake inputs
nix flake update

# Check flake validity
nix flake check
```

## Architecture

### Flake Structure

`flake.nix` defines one NixOS system config (`hp15seq`) and five standalone home-manager configs. All use nixpkgs unstable. Inputs (`inputs`) and flake self-reference (`outputs`) are passed into every module via `specialArgs`/`extraSpecialArgs`.

### Host Profiles (home-manager/)

Each host directory contains a `home.nix` that selectively imports from the shared module library. The hosts vary significantly in scope:

- **nixos-hp/rohits/** — Full desktop: xmonad, xmobar, picom, rofi, browsers, email accounts, neovim, terminals. Imports ~24 modules.
- **opensuse-hp/rohit/** — Mid-range: terminals, browsers, neovim, fish. ~7 modules.
- **fedora/rohit/** — Mid-range, mirrors opensuse-hp: kitty, fish, tmux, starship, neovim, browsers. ~7 modules. Fedora's own GNOME/Wayland session owns the desktop, so no WM/shell modules (and no `xdg.nix`, whose portal config would conflict with Fedora's).
- **ubuntu-wsl/rohit/** — Minimal CLI: fish, starship, neovim, basic CLI tools.
- **cloud-vms/scripts-vm/** — Bare minimum: fish, starship, disk usage tool.

### Shared Modules (modules/home-manager/)

All reusable configuration lives here. Each file or directory is one logical unit (a program or service). Modules are **config-only** — they directly set `programs.*`/`services.*` options without defining custom module options.

- Simple programs: single `.nix` file (e.g., `fish.nix`, `tmux.nix`, `starship.nix`)
- Complex programs: directory with `default.nix` + supporting files (e.g., `nvim/` has Lua configs and snippets, `xmonad/` has Haskell source)

Module function signature: `{ pkgs, config, lib, outputs, inputs, ... }:`

### NixOS System Config (nixos/hp15seq/)

`configuration.nix` handles system-level concerns: boot (GRUB EFI), display (GNOME + GDM), networking, AMD GPU, PipeWire audio, Bluetooth, Podman, fonts, user accounts. Imports `modules/nixos/laptop-battery.nix` for power management.

### Overlays & Packages

`overlays/default.nix` exports three overlays applied by all host configs:
- `additions` — custom packages from `pkgs/`
- `modifications` — overrides to existing nixpkgs
- `unstable-packages` — access to unstable channel (currently same as main)

`pkgs/default.nix` is the entry point for custom package definitions using `callPackage`.

## Key Conventions

- **Formatter**: Alejandra (not nixpkgs-fmt). Run `nix fmt` before committing.
- **Imports**: All home-manager host configs import modules via relative paths to `modules/home-manager/`.
- **Overlays**: Every host config applies the same three overlays from `outputs.overlays.*`.
- **State versions**: Don't change `home.stateVersion` — it controls migration behavior, not the package set.
- **Shell**: Fish is the primary shell across all hosts. Bash is configured as fallback.
- **Editor**: Neovim with CoC for LSP, Treesitter for syntax. Config is split across `nvim/lua/` files.

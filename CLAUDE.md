# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS dotfiles repo for the machine `jon-nixos` (x86_64-linux). It has two independent flakes:

- `nixos/` — NixOS system configuration (requires `sudo nixos-rebuild`)
- `home-manager/` — user-level Home Manager configuration for user `jon`

Both flakes track `nixos-unstable`.

## Key Commands

Apply Home Manager changes:
```
hms        # home-manager switch --flake ~/dotfiles/home-manager#jon
hmsf       # git add -A && hms  (stage everything first)
```

Apply NixOS system changes:
```
nrs        # sudo nixos-rebuild switch --flake ~/dotfiles/nixos
nrsf       # git add -A && nrs
```

Dotfiles git shortcuts:
```
dgit       # git -C ~/dotfiles/
dcommit    # git add -A && git commit -m
dpush      # git push
```

Validate without applying:
```
nix flake check ./home-manager
nix flake check ./nixos
```

## CI & formatting

- `.github/workflows/check.yml` runs `nix flake check` on both flakes on push/PR.
- `home-manager/flake.nix` exposes pre-commit hooks (`nixfmt-rfc-style`, `deadnix`) and a `devShell` that installs them. Enter with `nix develop ./home-manager` to get the shell hook.
- Both flakes must format cleanly under `nixfmt-rfc-style` or CI fails.

## Architecture

### `nixos/`
- `flake.nix` — pulls nixos-unstable + claude-code-nix + ClearVision theme flake
- `configuration.nix` — system-level config: boot (AMD GPU + systemd-boot), networking, Hyprland, Steam, Ollama, Syncthing, Flatpak, fonts, user `jon`. Also: `i18n.inputMethod` enables fcitx5 with `qt6Packages.fcitx5-chinese-addons` (zh_CN locale + extensive CJK fonts declared in `fonts.packages`). `programs.nix-ld` is enabled for running non-Nix dynamic binaries.
- `hardware-configuration.nix` — hardware scan output (do not edit manually)
- `modules/ly.nix` — ly display manager with Game of Life animation (asset at `modules/ly-animation/`)

### `home-manager/`
- `flake.nix` — pulls nixos-unstable + home-manager + awww (wallpaper animator) + nixvim + pre-commit-hooks
- `home.nix` — user config: imports all programs, declares packages, sets up Hyprland dotfiles via `home.file`, session variables, GPG, pass, zathura, hyprsunset, udiskie. Also writes `xdg.configFile."fcitx5/config"` with `force = true` (trigger key = `Control+space`); changing it requires rerunning `hms`.
- `programs/` — one file per program:
  - `nixvim.nix` — full Neovim config via nixvim: kanagawa theme, LSP (ts_ls, clangd, nixd, tinymist, astro, tailwind, etc.), Telescope, Oil, blink-cmp, conform-nvim (format-on-save), treesitter, flash, gitsigns
  - `zsh.nix` — zsh + starship + vi-mode + autocomplete; defines all aliases including `hms`/`nrs`; includes `cpp()` helper (compiles + runs `.cpp` with `-std=c++23 -O2 -fsanitize=address`)
  - `kitty.nix` — terminal with 80% opacity, tab keybindings (ctrl+1-9, ctrl+shift+t/n)
  - `mpv.nix` — mpv with uosc script + custom `mpv-font-picker.lua` (randomized/scrollable font picker via ctrl+alt+f/F)
  - `tofi.nix` — app launcher config
  - `vesktop.nix` — Vesktop (Discord) with ClearVision theme
  - `discord-rpc.nix` — Discord Rich Presence integration
  - `fastfetch.nix` — fastfetch display config
  - `file-explorer.nix` — file manager config
- `scripts/wallpaper.nix` — builds `random-wallpaper` shell script (picks random file from `~/Wallpapers/`, uses awww for animated transitions)
- `dotfiles/hypr/` — Hyprland config files (hyprland.conf, hypridle.conf, hyprlock.conf, hyprsunset.conf) copied directly to `~/.config/hypr`

### Nix patterns used
- `home.file` with `source` + `recursive = true` for config directories
- `writeShellScriptBin` for inline shell scripts as packages
- `xdg.configFile` for XDG config entries (use `force = true` to overwrite files an app would otherwise generate itself)
- `extraSpecialArgs` to pass flake inputs (e.g., `awww`) into modules

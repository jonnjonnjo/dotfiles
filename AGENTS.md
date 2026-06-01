# AGENTS.md

Two independent Nix flakes — one for the system (`nixos/`), one for the user
(`home-manager/`). Both pin `nixos-unstable`.

## Apply commands (defined in `home-manager/programs/zsh.nix` aliases)

| Command | Action |
|---------|--------|
| `hms` | `home-manager switch --flake ~/dotfiles/home-manager#jon && exec zsh` |
| `hmsf` | `git add -A && hms` (stages everything first) |
| `nrs` | `sudo nixos-rebuild switch --flake ~/dotfiles/nixos` |
| `nrsf` | `git add -A && nrs` |
| `dcommit` | `git add -A && git commit -m` (always stages all) |
| `dpush` | `git push` |
| `dgit` | `git -C ~/dotfiles/` |
| `nfu` | updates **both** flakes' lockfiles at once |

`hms`/`hmsf` reload the shell (`exec zsh`). NixOS changes require a reboot
or `nrs`.

## Validate & format

```sh
nix flake check ./home-manager   # CI check
nix flake check ./nixos          # CI check
nix develop ./home-manager       # dev shell with pre-commit hooks
```

Format: `nixfmt-rfc-style` on `.nix` files (not `nixfmt-classic`).
Pre-commit hooks: `nixfmt-rfc-style` + `deadnix` on `.nix` only.

## Architecture notes

- `nixos/modules/ly.nix` references assets in `nixos/modules/ly-animation/`
- `xdg.configFile` with `force = true` overwrites auto-generated configs (e.g. fcitx5)
- `extraSpecialArgs` passes flake inputs (e.g. `awww`, `jzw`) into modules
- `home.file` with `source` + `recursive = true` copies entire dirs (e.g. `dotfiles/hypr/`)
- `writeShellScriptBin` for inline packages (wallpaper, brightness, firefox profiles)
- Screenshot keybindings documented in `SCREENSHOT.md`

## Constraints

- User: `jon`, hostname: `jon-nixos`, arch: `x86_64-linux`
- `home.stateVersion = "25.11"`, `system.stateVersion = "25.11"` (read the comment before bumping)
- `hardware-configuration.nix` — do not edit manually
- `home-manager/.claude/settings.local.json` allows WebFetch to github.com

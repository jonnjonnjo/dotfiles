# Nvim Keybindings & Movement Guide

Leader key: `Space`

## Movement (the fast way)

| Key | Action |
|-----|--------|
| `s` + 2 chars + label | **Flash jump** — teleport anywhere visible on screen |
| `S` + label | Flash treesitter — jump to/select a syntax node |
| `5j` / `12k` | Jump N lines (relative numbers make this easy) |
| `<C-d>` / `<C-u>` | Half-page scroll down / up |
| `{` / `}` | Jump by paragraph / blank-line block |
| `H` / `M` / `L` | Top / Middle / Bottom of visible screen |
| `/word` → `n` / `N` | Search forward / backward |
| `gg` / `G` | Top / bottom of file |
| `%` | Jump to matching bracket |

## Windows & Splits

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |

## Files

| Key | Action |
|-----|--------|
| `<leader>e` | Open Oil file explorer |
| `<leader>ff` | Telescope: find files |
| `<leader>fg` | Telescope: live grep |
| `<leader>fb` | Telescope: open buffers |

## LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover docs |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>gl` | Open diagnostic float |

## Editing

| Key | Action |
|-----|--------|
| `gc` + motion | Toggle comment |
| `ys` + motion + char | Surround with char (nvim-surround) |
| `ds` + char | Delete surrounding char |
| `cs` + old + new | Change surrounding char |

## Competitive Programming Templates

| Key | Action |
|-----|--------|
| `<leader>tcpc` | Copy CP template to clipboard |
| `<leader>tcpi` | Insert CP template at cursor |

## Misc

| Key | Action |
|-----|--------|
| `<leader>mp` | Toggle Markdown preview |

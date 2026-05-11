# Neovim (nixvim) cheatsheet

Companion to `nixvim.nix`. Two parts:

1. What this config does and adds.
2. Native Vim/Neovim keys worth knowing.

`<leader>` is `Space`.

---

## 1. Current config

### Options

| Option | Value |
| --- | --- |
| `number` / `relativenumber` | on (hybrid line numbers) |
| `clipboard` | `unnamedplus` (yank/paste shares system clipboard) |
| `shiftwidth` / `tabstop` | 2 spaces, `expandtab` |
| `wrap` | off |
| `scrolloff` | 8 (keeps cursor 8 lines from edge) |
| `signcolumn` | always shown |
| `undofile` | on (persistent undo across sessions) |
| `ignorecase` + `smartcase` | case-insensitive search unless you type uppercase |
| `updatetime` | 250 ms (faster CursorHold / gitsigns) |

### Colorscheme

- `kanagawa` with `transparent = true`.

### Plugins enabled

| Plugin | Purpose |
| --- | --- |
| **flash.nvim** | jump anywhere with `s` / treesitter-aware jump with `S` |
| **telescope** + fzf-native | fuzzy finder for files / grep / buffers |
| **oil.nvim** | edit the filesystem like a buffer (`<leader>e`) |
| **blink-cmp** | completion (Enter to accept, signature help, auto docs after 100 ms) |
| **treesitter** | syntax-aware highlight + indent |
| **gitsigns** | git diff in signcolumn (add/change/delete markers) |
| **lualine** | statusline (kanagawa theme) |
| **which-key** | popup that lists keybindings as you type a leader chord |
| **trouble.nvim** | pretty diagnostics / quickfix UI |
| **nvim-autopairs** | auto-close brackets/quotes |
| **nvim-surround** | add/change/delete surrounding pairs (`ys`, `cs`, `ds`) |
| **comment.nvim** | `gcc` line / `gc` motion to toggle comments |
| **indent-blankline** | indent guides |
| **fidget.nvim** | LSP progress in corner |
| **web-devicons** | filetype icons |
| **typst-vim** | typst filetype support |
| **markdown-preview** | browser preview (`<leader>mp`) |
| **auto-save** | autosaves **only typst files** (config in `nixvim.nix`) |
| **conform-nvim** | format on save (500 ms timeout, LSP fallback) |

### LSP servers

`ts_ls`, `clangd`, `nixd`, `tinymist` (typst), `astro`, `tailwindcss`, `marksman` (markdown), `lua_ls`, `yamlls`, `kotlin_language_server`. Inlay hints are enabled.

### Formatters (on save)

| Filetype | Formatter |
| --- | --- |
| nix | `nixfmt` |
| lua | `stylua` |
| cpp | `clang-format` |
| kotlin | `ktlint` |
| js/ts/astro/css | `prettier` |
| other | LSP-provided formatter as fallback |

### Custom keymaps from this config

| Key | Mode | Does |
| --- | --- | --- |
| `s` | n/x/o | flash jump (interactive 2-char search) |
| `S` | n/x/o | flash treesitter jump |
| `<C-h/j/k/l>` | n | move between splits |
| `<leader>ff` | n | Telescope find files |
| `<leader>fg` | n | Telescope live grep |
| `<leader>fb` | n | Telescope buffers |
| `<leader>e` | n | Oil file explorer |
| `<leader>mp` | n | toggle markdown preview |
| `gd` | n | LSP go to definition |
| `gr` | n | LSP references |
| `gi` | n | LSP implementation |
| `K` | n | LSP hover docs |
| `<leader>rn` | n | LSP rename symbol |
| `<leader>ca` | n | LSP code action |
| `[d` / `]d` | n | prev / next diagnostic |
| `<leader>gl` | n | open diagnostic float |

---

## 2. Native Vim / Neovim reference

### Modes

| Mode | Enter | Exit |
| --- | --- | --- |
| Normal | `Esc` / `<C-[>` | — |
| Insert | `i a I A o O` | `Esc` |
| Visual | `v` (char) `V` (line) `<C-v>` (block) | `Esc` |
| Replace | `R` (overwrite) `r{c}` (single char) | `Esc` |
| Command | `:` | `Esc` |
| Terminal | `:terminal` then `i` | `<C-\><C-n>` |

### Motion (normal & visual)

| Key | Move |
| --- | --- |
| `h j k l` | left, down, up, right |
| `w` / `W` | next word / WORD start |
| `e` / `E` | next word / WORD end |
| `b` / `B` | prev word / WORD start |
| `ge` | prev word end |
| `0` | line start (column 0) |
| `^` | first non-blank of line |
| `$` | line end |
| `g_` | last non-blank of line |
| `f{c}` / `F{c}` | jump to next/prev `{c}` on line |
| `t{c}` / `T{c}` | jump till next/prev `{c}` |
| `;` / `,` | repeat last `f/t` forward / backward |
| `gg` | top of file |
| `G` | bottom of file |
| `{n}G` or `:{n}` | line `n` |
| `H` / `M` / `L` | top / middle / bottom of screen |
| `(` / `)` | sentence back / forward |
| `{` / `}` | paragraph back / forward |
| `%` | matching `()[]{}` (or `#if`/`#endif`) |
| `<C-d>` / `<C-u>` | half-page down / up |
| `<C-f>` / `<C-b>` | full page down / up |
| `<C-e>` / `<C-y>` | scroll one line down / up |
| `zz` / `zt` / `zb` | center / top / bottom screen on cursor |
| `*` / `#` | search word under cursor forward / backward |
| `n` / `N` | repeat last search same / opposite direction |
| `''` / ` `` ` | jump to position before last jump |
| `<C-o>` / `<C-i>` | jumplist back / forward |

### Editing

| Key | Action |
| --- | --- |
| `i` / `a` | insert before / after cursor |
| `I` / `A` | insert at line start / end |
| `o` / `O` | new line below / above |
| `x` / `X` | delete char under / before cursor |
| `r{c}` | replace single char |
| `s` / `S` | substitute char / whole line (enters insert) *(here remapped to flash; use `cl` / `cc` instead)* |
| `c{motion}` | change |
| `cc` | change line |
| `C` | change to end of line |
| `d{motion}` | delete |
| `dd` | delete line |
| `D` | delete to end of line |
| `y{motion}` | yank (copy) |
| `yy` / `Y` | yank line |
| `p` / `P` | paste after / before |
| `]p` / `[p` | paste with indent adjusted |
| `u` / `<C-r>` | undo / redo |
| `U` | undo all changes on line |
| `.` | repeat last change |
| `J` | join line below into current |
| `gJ` | join without inserting space |
| `~` | toggle case of char |
| `g~{motion}` / `gu{motion}` / `gU{motion}` | toggle / lower / upper case |
| `>{motion}` / `<{motion}` | indent / dedent |
| `>>` / `<<` | indent / dedent line |
| `=` / `={motion}` | auto-indent |
| `==` | auto-indent line |
| `gq{motion}` | reformat (wrap) text |

### Text objects (use after `d`, `c`, `y`, `v`)

| Object | Meaning |
| --- | --- |
| `iw` / `aw` | inner / a word |
| `iW` / `aW` | inner / a WORD |
| `is` / `as` | inner / a sentence |
| `ip` / `ap` | inner / a paragraph |
| `i"` `i'` `` i` `` | inside quotes |
| `i(` `i[` `i{` `i<` | inside brackets (also `ib`, `iB`) |
| `a(` `a[` `a{` ... | including brackets |
| `it` / `at` | inside / around HTML/XML tag |
| Example: `ci"` change inside quotes, `da{` delete a block. |

### Visual mode

| Key | Action |
| --- | --- |
| `v` | char-wise |
| `V` | line-wise |
| `<C-v>` | block-wise |
| `o` | move to other end of selection |
| `gv` | reselect last visual area |
| `>` / `<` | indent / dedent selection |
| `=` | auto-indent selection |
| `~` / `u` / `U` | toggle / lower / upper case |
| `:` | start command on selection (`:'<,'>`) |

#### Block insert (column edit)

`<C-v>` → select column → `I` (or `A`) → type → `Esc` → insertion applied to every selected line.

### Search & substitute

| Key | Action |
| --- | --- |
| `/pattern` / `?pattern` | search forward / backward |
| `n` / `N` | next / previous match |
| `:noh` | clear highlight |
| `:%s/foo/bar/g` | substitute all in file |
| `:%s/foo/bar/gc` | with confirm |
| `:'<,'>s/.../.../g` | substitute in visual selection |
| `&` | repeat last `:s` on current line |
| `g&` | repeat last `:s` on whole file |

### Registers

| Use | How |
| --- | --- |
| Yank to register `a` | `"ay{motion}` |
| Paste from register `a` | `"ap` |
| `"+` | system clipboard (already implicit via `clipboard=unnamedplus`) |
| `"0` | last yank |
| `"_` | black hole (discard, e.g. `"_dd`) |
| `:reg` | list all registers |

### Marks

| Key | Action |
| --- | --- |
| `m{a-z}` | set local mark |
| `m{A-Z}` | set global mark (file + position) |
| `` `a `` | jump to mark `a` (exact column) |
| `'a` | jump to mark `a` (line start) |
| `:marks` | list marks |

### Macros

| Key | Action |
| --- | --- |
| `q{a}` ... `q` | record into register `a` |
| `@a` | replay |
| `@@` | replay last |
| `{n}@a` | replay `n` times |

### Windows / splits

| Key | Action |
| --- | --- |
| `<C-w>s` / `:split` | horizontal split |
| `<C-w>v` / `:vsplit` | vertical split |
| `<C-w>q` | close window |
| `<C-w>o` | close all but current |
| `<C-w>h/j/k/l` | move focus *(remapped here to bare `<C-h/j/k/l>`)* |
| `<C-w>H/J/K/L` | move window |
| `<C-w>=` | equalize sizes |
| `<C-w>+` / `<C-w>-` | resize height |
| `<C-w>>` / `<C-w><` | resize width |
| `<C-w>_` / `<C-w>|` | maximize height / width |

### Tabs

| Key | Action |
| --- | --- |
| `:tabnew` / `:tabe {file}` | new tab |
| `gt` / `gT` | next / previous tab |
| `{n}gt` | go to tab `n` |
| `:tabclose` | close tab |
| `:tabonly` | close all other tabs |

### Buffers

| Key | Action |
| --- | --- |
| `:e {file}` | open file |
| `:bn` / `:bp` | next / previous buffer |
| `:bd` | delete buffer |
| `:ls` / `:buffers` | list |
| `<C-^>` | toggle to alternate buffer |

### Folds

| Key | Action |
| --- | --- |
| `zc` / `zo` | close / open fold |
| `za` | toggle fold |
| `zM` / `zR` | close / open all folds |
| `zj` / `zk` | next / previous fold |

### Quickfix / location list

| Key | Action |
| --- | --- |
| `:copen` / `:cclose` | quickfix open / close |
| `:cnext` / `:cprev` (`]q` / `[q` if mapped) | next / prev entry |
| `:lopen` ... `:lnext` | location list variants |

### Command-line useful bits

| Key | Action |
| --- | --- |
| `q:` | open command history in editable buffer |
| `q/` | open search history |
| `<C-r>"` (in `:` or `/`) | paste from default register |
| `<Tab>` | wildmenu completion |
| `:!cmd` | shell out |
| `:r !cmd` | insert command output |
| `:set` / `:set?` | inspect options |
| `:verbose map {key}` | who mapped this key? |
| `:checkhealth` | run health diagnostics |
| `:Inspect` | what syntax / treesitter group is under cursor |

### Misc

| Key | Action |
| --- | --- |
| `ZZ` | save and quit |
| `ZQ` | quit without saving |
| `<C-g>` | show filename + line info |
| `g<C-g>` | word/line/char count |
| `ga` | show char code under cursor |
| `gx` | open URL / file under cursor in system handler |
| `gf` | jump to file under cursor |
| `K` | run keywordprg (here: LSP hover) |

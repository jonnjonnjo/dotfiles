{ ... }:
{
  programs.nixvim = {
    globals.mapleader = " ";
    enable = true;
    version.enableNixpkgsReleaseCheck = false;

    opts = {
      number = true;
      clipboard = "unnamedplus";
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      wrap = false;
      scrolloff = 8;
      signcolumn = "yes";
      termguicolors = true;
      updatetime = 250;
      undofile = true;
      ignorecase = true;
      smartcase = true;
    };

    # In Oil's confirmation popup, map <CR> to confirm (alongside the default y/Y/o/O).
    autoCmd = [
      {
        event = "FileType";
        pattern = "oil_preview";
        callback.__raw = ''
          function(args)
            vim.keymap.set("n", "<CR>", "y", { buffer = args.buf, remap = true, nowait = true })
          end
        '';
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        transparent_background = true;
        integrations = {
          telescope.enabled = true;
          which_key = true;
          gitsigns = true;
          indent_blankline.enabled = true;
          blink_cmp = true;
          treesitter = true;
          lsp_trouble = true;
        };
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash jump";
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = "<cmd>lua require('flash').treesitter()<cr>";
        options.desc = "Flash treesitter";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Move to left window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Move to window below";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Move to window above";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Move to right window";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
        options.desc = "Find buffers";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Oil<cr>";
        options.desc = "File explorer";
      }
      {
        mode = "n";
        key = "<leader>mp";
        action = "<cmd>MarkdownPreviewToggle<cr>";
        options.desc = "Markdown preview toggle";
      }
      {
        mode = "n";
        key = "<leader>sv";
        action = "<cmd>vsp<cr>";
        options.desc = "Vertical split";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>sp<cr>";
        options.desc = "Horizontal split";
      }
      {
        mode = "n";
        key = "<leader>nh";
        action = "<cmd>nohlsearch<cr>";
        options.desc = "Clear search highlights";
      }
    ];

    diagnostics = {
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
    };

    extraConfigLua = ''
      local TEMPLATE_DIR = vim.fn.expand("~/.config/nvim/templates/competitive-programming")

      local function copy_template_to_clipboard()
        require("telescope.builtin").find_files({
          prompt_title = "CP Templates",
          cwd = TEMPLATE_DIR,
          find_command = { "ls", "-1r" },
          attach_mappings = function(prompt_bufnr, _)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              if selection then
                local filepath = selection.path or selection.filename
                local file = io.open(filepath, "r")
                if file then
                  local content = file:read("*all")
                  file:close()
                  vim.fn.setreg("+", content)
                  vim.notify("Template copied to clipboard: " .. selection.filename, vim.log.levels.INFO)
                else
                  vim.notify("Error reading file: " .. filepath, vim.log.levels.ERROR)
                end
              end
            end)
            return true
          end,
        })
      end

      local function insert_template_at_cursor()
        require("telescope.builtin").find_files({
          prompt_title = "CP Templates",
          cwd = TEMPLATE_DIR,
          find_command = { "ls", "-1r" },
          attach_mappings = function(prompt_bufnr, _)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              if selection then
                local filepath = selection.path or selection.filename
                local file = io.open(filepath, "r")
                if file then
                  local content = file:read("*all")
                  file:close()
                  local lines = {}
                  for line in content:gmatch("[^\r\n]+") do
                    table.insert(lines, line)
                  end
                  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, lines)
                  vim.notify("Template inserted: " .. selection.filename, vim.log.levels.INFO)
                else
                  vim.notify("Error reading file: " .. filepath, vim.log.levels.ERROR)
                end
              end
            end)
            return true
          end,
        })
      end

      vim.keymap.set("n", "<leader>tcpc", copy_template_to_clipboard, { desc = "CP Template to Clipboard" })
      vim.keymap.set("n", "<leader>tcpi", insert_template_at_cursor, { desc = "CP Template Insert at cursor" })

      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local fmt = require("luasnip.extras.fmt").fmt

    '';

    plugins = {
      auto-save = {
        enable = true;
        settings = {
          enabled = true;
          condition = {
            __raw = ''
              function(buf)
                local ft = vim.bo[buf].filetype
                local allowed = { "typst" }
                for _, v in ipairs(allowed) do
                  if ft == v then return true end
                end
                return false
              end
            '';
          };
        };
      };

      flash.enable = true;

      fidget.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          auyto_install = true;
          indent.enable = true;
        };
      };

      oil = {
        enable = true;
        settings = {
          view_options.show_hidden = true;
        };
      };

      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };

      web-devicons = {
        enable = true;
      };

      lualine = {
        enable = true;
        settings.options.theme = "catppuccin";
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "~";
          untracked.text = "▎";
        };
      };

      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
        };
      };

      nvim-autopairs.enable = true;

      comment.enable = true;

      which-key = {
        enable = true;
        settings.win = {
          no_overlap = true;
          padding = [
            2
            1
          ];
          title_pos = "left";
        };
      };

      nvim-surround.enable = true;

      indent-blankline.enable = true;

      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "default";
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "fallback"
            ];
            "<CR>" = [
              "accept"
              "fallback"
            ];
          };
          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
          signature.enabled = true;
          completion = {
            ghost_text.enabled = true;
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 100;
            };
          };
          appearance.nerd_font_variant = "mono";
        };
      };

      typst-vim.enable = true;

      lsp = {
        enable = true;
        inlayHints = true;

        servers = {
          emmet_language_server.enable = true;
          kotlin_language_server.enable = true;
          yamlls.enable = true;
          lua_ls.enable = true;
          astro.enable = true;
          tailwindcss.enable = true;
          marksman.enable = true;
          nixd.enable = true;
          clangd.enable = true;
          tinymist.enable = true;
          ts_ls.enable = true;
        };

        keymaps = {
          lspBuf = {
            "gd" = "definition";
            "gr" = "references";
            "gi" = "implementation";
            "K" = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
          };
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>gl" = "open_float";
          };
        };
      };

      trouble = {
        enable = true;
      };

      markdown-preview = {
        enable = true;
        settings.auto_close = 1;
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_format = "fallback";
            timeout_ms = 500;
          };
          formatters_by_ft = {
            kotlin = [ "ktlint" ];
            cpp = [ "clang_format" ];
            nix = [ "nixfmt" ];
            lua = [ "stylua" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            astro = [ "prettier" ];
            css = [ "prettier" ];
          };
        };
      };
    };
  };
}

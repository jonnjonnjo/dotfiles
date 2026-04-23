{ config, pkgs, ... }:
{
  programs.nixvim = {
    globals.mapleader = " ";
    enable = true;
	
    opts = {
      number = true;
      clipboard = "unnamedplus";
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      wrap = false;
      scrolloff = 4;
      signcolumn = "yes";
      termguicolors = true;
      updatetime = 250;
      undofile = true;
      ignorecase = true; 
      smartcase = true;
    };

    # colorschemes.vscode.enable= true;
    # colorschemes.melange.enable= true;
    colorschemes.kanagawa.enable= true;
    # colorschemes.kanagawa-paper.enable= true;
    # colorschemes.cyberdream.enable= true;
    # colorschemes.rose-pine.enable= true;

    keymaps = [
      { mode = ["n" "x" "o"]; key = "s"; action = "<cmd>lua require('flash').jump()<cr>"; options.desc = "Flash jump"; }
      { mode = ["n" "x" "o"]; key = "S"; action = "<cmd>lua require('flash').treesitter()<cr>"; options.desc = "Flash treesitter"; }
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Move to left window"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Move to window below"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Move to window above"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Move to right window"; }
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; options.desc = "Find files"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; options.desc = "Live grep"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; options.desc = "Find buffers"; }
      { mode = "n"; key = "<leader>e";  action = "<cmd>Oil<cr>"; options.desc = "File explorer"; }
    ];

    plugins = {
      flash.enable = true;

      treesitter.enable = true;

      oil.enable = true;

      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };

      web-devicons = {
        enable = true;
      };

      lualine = {
        enable = true;
        settings.options.theme = "onelight";
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text          = "▎";
          change.text       = "▎";
          delete.text       = "";
          topdelete.text    = "";
          changedelete.text = "~";
          untracked.text    = "▎";
        };
      };

      nvim-autopairs.enable = true;

      comment.enable = true;

      which-key = {
        enable = true;
        settings = {
          win = {
            "no_overlap" = true;
             padding = "{2,1}";
             title_post =  "left";
          };

        };
      };

      nvim-surround.enable = true;

      indent-blankline.enable = true;

      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }   
            { name = "luasnip"; }    
            { name = "buffer"; }     
            { name = "path"; }       
          ];
          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
          };
        };
      };

      luasnip.enable = true;
      cmp_luasnip.enable = true;

      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          nixd.enable = true;
          clangd.enable =  true;
        };
        keymaps = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
        };
        lspBuf = {
          "gd" = "definition";
          "gr" = "references";
          "gi" = "implementation";
          "K"  = "hover";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };

      };


      trouble = {
        enable = true;
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
          formatters_by_ft = {
            cpp = [ "clang_format" ];
            nix = [ "nixfmt" ];
            lua = [ "stylua" ];
          };
        };
      };
    };
  };
}

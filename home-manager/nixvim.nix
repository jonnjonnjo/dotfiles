{ config, pkgs, ... }:
{
  programs.nixvim = {
    globals.mapleader = " ";
    enable = true;
	
    opts = {
      number = true;
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
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; options.desc = "Find files"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; options.desc = "Live grep"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; options.desc = "Find buffers"; }
      { mode = "n"; key = "<leader>e";  action = "<cmd>Oil<cr>"; options.desc = "File explorer"; }
    ];

    plugins = {
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

      which-key.enable = true;

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
        };
      };


      trouble = {
        enable = true;
      };

      lsp-format = {
        enable = true;
      };
    };
  };
}

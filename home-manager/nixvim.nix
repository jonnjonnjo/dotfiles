{ config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
	
    opts = {
      number = true;
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

    # colorschemes.vscode.enable= true;
    # colorschemes.melange.enable= true;
    colorschemes.kanagawa.enable= true;
    # colorschemes.kanagawa-paper.enable= true;
    # colorschemes.cyberdream.enable= true;
    # colorschemes.rose-pine.enable= true;

    global.mapleader = " ";

    plugins = {
      treesitter.enable = true;

      oil.enable = true;

      cmp = {
        enable = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };

      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          nixd.enable = true;
        };
      };
    };
  };
}

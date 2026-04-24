{pkgs,...}:
{

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.zsh-autocomplete;
        file = "share/zsh-autocomplete/zsh-autocomplete.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];


    initExtra = ''
      zstyle ':autocomplete:*' min-input 0
      zstyle ':autocomplete:*' list-lines 8
      zstyle ':completion:*' completer _expand _complete _files

      zvm_vi_yank () {
        zvm_yank
        printf %s "''${CUTBUFFER}" | wl-copy -n
        zvm_exit_visual_mode
      }
    '';
    
  };

  programs.starship = {
    enable = true;
  };
}

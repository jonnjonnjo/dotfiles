{pkgs,...}:
{

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ff = "fastfetch";
      dotf = "cd ~/dotfiles";
      ll = "ls -la";
      wgu = "wg-quick up";
      wgd = "wg-quick down";
    };  
    
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

      cpp(){
        local name="''${1%.cpp}"
        
        # Changed -std=c++17 to -std=c++23
        g++ -std=c++23 -O2 -Wall -Wextra -fsanitize=address "$name.cpp" -o "$name"
        if [ $? -eq 0 ]; then
          ./"$name"
        fi
      }
    '';
    
  };

  programs.starship = {
    enable = true;
  };
}

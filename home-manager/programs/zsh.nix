{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ff = "fastfetch";
      dot = "cd ~/dotfiles";
      dgit = "git -C ~/dotfiles/";
      dcommit = "git -C ~/dotfiles add -A && git -C ~/dotfiles commit -m";
      dpush = "git -C ~/dotfiles push";
      hms = "home-manager switch --flake ~/dotfiles/home-manager#jon";
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos";
      hmsf = "git -C ~/dotfiles add -A && home-manager switch --flake ~/dotfiles/home-manager#jon";
      nrsf = "git -C ~/dotfiles add -A && sudo nixos-rebuild switch --flake ~/dotfiles/nixos";
      wgup = "sudo wg-quick up";
      wgdown = "sudo wg-quick down";
      wgstat = "sudo wg show";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
      g = "git";
      gs = "git status";
      ga = "git add";
      gaa = "git add -A";
      gc = "git commit";
      gcm = "git commit -m";
      gp = "git push";
      gpl = "git pull";
      gl = "git log --oneline --graph --decorate --all";
      gd = "git diff";
      gco = "git checkout";
      gb = "git branch";
      stremio = "GDK_BACKEND=x11 ELECTRON_OZONE_PLATFORM_HINT=x11 stremio";
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

    initContent = ''
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

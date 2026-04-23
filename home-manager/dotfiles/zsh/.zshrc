# zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light jeffreytse/zsh-vi-mode
# zinit light marlonrichert/zsh-autocomplete


alias ff='fastfetch'
alias dotf='cd ~/dotfiles'
alias wgu='wg-quick up'
alias wgd='wg-quick down'


cpp(){
  local name="${1%.cpp}"
  g++ -std=c++17 -O2 -Wall -Wextra -fsanitize=address "$name.cpp" -o "$name"
  if [ $? -eq 0 ]; then
    # echo " --[Running : $name]--"
    ./"$name"
  fi
}

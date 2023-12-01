export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"

alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

plugins=(git)
source $ZSH/oh-my-zsh.sh

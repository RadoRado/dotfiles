export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Aliases

alias zconf="vi ~/.zshrc"
alias c="cd ~/code"
alias py="python3.4"
alias scm="plt-r5rs"
alias omgwtf="sudo kill -9 $(pgrep NetworkManager)"
alias rmd="vi README.md"

# Load z
source /home/radorado/code/z/z.sh

# Export nvm
export NVM_DIR="/home/radorado/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Send ssh key to server
send_key() {
  cat ~/.ssh/id_rsa.pub | ssh $1 "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"
}


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source /home/radorado/.rvm/scripts/rvm

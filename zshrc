export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Aliases

alias zconf="vi ~/.zshrc"
alias c="cd ~/code"
alias scm="plt-r5rs"
alias omgwtf="sudo kill -9 $(pgrep NetworkManager)"
alias rmd="vi README.md"

alias gs="git status"
alias gm="git commit"
alias ga="git add"
alias up="git push"
alias down="git pull"
alias cb="git checkout $1"
alias cbb="git checkout -b $1"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias v="vi"
alias pmr="python3 manage.py runserver"
alias pmt="python3 manage.py test"

# Load z
source /home/radorado/code/z/z.sh

# Load j
eval "$(jump shell zsh)"

# Export nvm
export NVM_DIR="/home/radorado/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Send ssh key to server
send_key() {
  cat ~/.ssh/id_rsa.pub | ssh $1 "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"
}

# Zip entire folder
zap() {
  zip -r $1 $(ls)
}

pygo() {
  workon $1 && j $1
}

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# virtualenvwrapper

export WORKON_HOME=$HOME/code/envs
export PROJECT_HOME=$HOME/code
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export SCALA_HOME="/home/radorado/scala-2.11.8/"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=$PATH:$SCALA_HOME/bin


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
alias goto="git checkout $1"
alias cbb="git checkout -b $1"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gbpurge="git branch --merged | grep -v \"\*\" | grep -v \"master\" | xargs -n 1 git branch -d"
alias b="git branch | cut -c 3- | fzy | xargs git checkout"
alias findpid="ps axww -o pid,user,%cpu,%mem,start,time,command | fzy | sed 's/^ *//' | cut -f1 -d' '"

alias v="vi"
alias pmr="python3 manage.py runserver"
alias pmt="python3 manage.py test"


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

killport() {
  fuser -k $1/tcp
}

copyfile() {
  xclip -i -selection clipboard -t $1
}

ww() {
  if [ -z $1 ]
  then
    echo "Pass project name"
  else
    cat "$HOME/code/ww/$1" | xargs sensible-browser > /dev/null 2>&1
  fi
}


# virtualenvwrapper

export WORKON_HOME=$HOME/code/python-envs
export PROJECT_HOME=$HOME/code
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /home/radorado/.local/bin/virtualenvwrapper.sh
export PATH="$HOME/.rbenv/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

eval "$(hub alias -s)"

# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.

if [ -d "$HOME/.oh-my-zsh" ]; then
  export ZSH="$HOME/.oh-my-zsh"
  ZSH_THEME="pygmalion"
  plugins=(git colorize)

  source $ZSH/oh-my-zsh.sh
fi
# User configuration

# Notwork
alias pingg="ping google.com"
alias ping8="ping 8.8.8.8"

# Docker
alias dip="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
drm() { docker rm $(docker ps -q -a); }
dri() { docker rmi $(docker images -q); }
alias dkd="docker run -d -P"
alias dki="docker run -t -i -P"
db() { docker build -t="$1" .; }

# Rancher
alias rex="rancher exec -ti"
alias rlog="rancher logs --tail=1000"

alias pd=pushd
alias gshb="git show-branch"

export ANSIBLE_NOCOWS=1

ZSH_SYNTAX_HIGHLIGHTING=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -e $ZSH_SYNTAX_HIGHLIGHTING ]]
   then source $ZSH_SYNTAX_HIGHLIGHTING
fi

# wholesome experience:
alias please=sudo

alias sc=systemctl
alias scls="systemctl list-unit-files"
alias scst="systemctl status"
alias ju="journalctl -u"

rconf() {
    if [ "$1" = "-d" ]; then
        shift
        rio config rm configmap/$1
        return
    fi
    if [ "$1" = "-c" ]; then
        mode=create
        shift
    else
        mode=update
    fi
    
    if [ $# -lt 3 ]; then
        echo 'rconf config-map key value'
        exit 1;
    fi

    if [ $mode = "create" ]; then
        echo -n $3 | rio config create -k $2 $1 -
    elif [ $mode = 'update' ]; then 
        echo -n $3 | rio config update -k $2 configmap/$1 -
    fi
}

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
export PS1="%(?:%{[01;37m%}➜ :%{[01;31m%}➜ ) %{%}%c%{[00m%} "


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/marcin/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby rvm mix colorize heroku) 

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# DFM radio
alias dfm="(unset DISPLAY; vlc http://stereo.dfm.nu)"

# Notwork
alias pingg="ping google.com"
alias ping8="ping 8.8.8.8"

# Docker
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
drm() { docker rm $(docker ps -q -a); }
dri() { docker rmi $(docker images -q); }
alias dkd="docker run -d -P"
alias dki="docker run -t -i -P"
db() { docker build -t="$1" .; }

# Rancher
alias rex="rancher exec -ti"
alias rlog="rancher logs --tail=1000"

alias xo=xdg-open
alias beep="paplay /usr/share/sounds/ubuntu/stereo/message.ogg"
alias fixkeyboard="sudo sh -c 'dumpkeys -k|grep -v Incr_Console|grep -v Decr_Console|grep -v Last_Console|loadkeys'"

alias pd=pushd
alias gshb="git show-branch"

export ANSIBLE_NOCOWS=1

env-dev() {
    local theme="$1"
    case "$theme" in
	    the-open)  theme=lumen;;
    esac
    export RACK_ENV=development ORG_NAME="$1" THEME="$theme"
}

env-test() {
    local theme="$1"
    case "$theme" in
	    the-open)  theme=lumen;;
    esac
    export RACK_ENV=test ORG_NAME="$1" THEME="$1"
}

# Git
pr_commits()
{
    if [ $# -lt 2 ]; then
		    echo Specify branch name and list of commits to be cherry-picked >&2
        echo pr_commits feature/my_feature 123456abcd .... >&2
		    return
	  fi
	  br=$1; shift
	  git checkout master
	  git pull
	  git checkout -b $br
	  while [ -n "$1" -a "$?"=0 ]; do
	      commit=$1; shift
	      git cherry-pick $commit
	  done
    if [ "$?"=0 ]; then
	      git push origin $br
    else
        echo "Errors, not pushing branch"
    fi
}

git-steal()
{
    git show $1:$2 > $2
}

nasz()
{
    case $1 in
        nip)
            echo 5223026714
        ;;
        krs)
            echo 0000552033
            ;;
        regon)
            echo 361255246
            ;;
        telefon)
            echo 0048222528144
            ;;
    esac
}


alias arm-objdump=/usr/local/mcuxpressoide-10.3.0_2200/ide/plugins/com.nxp.mcuxpresso.tools.linux_10.3.0.201811011841/tools/arm-none-eabi/bin/objdump

eval $(thefuck --alias)

ZSH_SYNTAX_HIGHLIGHTING=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -e $ZSH_SYNTAX_HIGHLIGHTING ]]
   then source $ZSH_SYNTAX_HIGHLIGHTING
fi

fortune $HOME/share/alejandro

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export EDITOR=emacs

shopt -s globstar
eval $(thefuck --alias)

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

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

export ANSIBLE_NOCOWS=1

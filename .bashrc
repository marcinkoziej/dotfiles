fortune $HOME/share/alejandro

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
 
function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

export EDITOR=emacs

shopt -s globstar
eval $(thefuck --alias)

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# RVM
#if [ -e /etc/profile.d/rvm.sh ]; then
#  source /etc/profile.d/rvm.sh
#fi

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

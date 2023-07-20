
export EDITOR=emacs
export PATH="$PATH:/usr/local/heroku/bin:$HOME/.local/bin:$HOME/bin:$HOME/.yarn/bin:$HOME/go/bin:$HOME/go/bin"
export GIT_EDITOR=vim
. "$HOME/.cargo/env"

export MAMBA_ROOT_PREFIX=$HOME/.cache/micromamba
eval "$(micromamba shell hook --shell=zsh)"

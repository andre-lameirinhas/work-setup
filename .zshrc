# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git docker docker-compose)
source $ZSH/oh-my-zsh.sh

# homebrew
eval "$(/usr/local/bin/brew shellenv)"

# starship
eval "$(starship init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# z
. ~/z.sh

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pyenv-virtualenvwrapper
export PYENV_VIRTUALENVWRAPPER_PREFER_PYENV="true"
export WORKON_HOME=$HOME/.virtualenvs
pyenv virtualenvwrapper_lazy

# alias
alias cat=bat
alias vim=nvim

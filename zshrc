export LANG="en_US.UTF-8"

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git docker docker-compose kubectl)
source $ZSH/oh-my-zsh.sh

# homebrew
if [[ $(uname -p) == "arm" ]]; then
    BIN_PATH="/opt/homebrew/bin"
else
    BIN_PATH="/usr/local/bin"
fi
eval "$($BIN_PATH/brew shellenv)"

# starship
eval "$(starship init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# z
. ~/z.sh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# gcloud
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

if [[ "$PYTHON_INSTALLED" = true ]]; then
    # pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # pyenv-virtualenvwrapper
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYENV="true"
    export WORKON_HOME=$HOME/.virtualenvs
    pyenv virtualenvwrapper_lazy

    # poetry
    export PATH="$HOME/.local/bin:$PATH"
fi

if [[ "$RUBY_INSTALLED" = true ]]; then
    # ruby
    source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
    source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
    chruby 3.3.0
fi

# aliases
alias cat=bat
alias vim=nvim
alias lg=lazygit

# set default editor
export EDITOR=vim
export VISUAL=vim

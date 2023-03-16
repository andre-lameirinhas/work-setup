#! /usr/bin/env bash
set -euo pipefail

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 'plugins=(git docker docker-compose)' >> ~/.zshrc

# brew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
brew update

# starship
brew install starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# git
brew install git git-gui

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# z
curl -o ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
echo '. ~/z.sh' >> ~/.zshrc

# bat
brew install bat
echo 'alias cat=bat' >> ~/.zshrc

# nvim
brew install neovim
echo 'alias vim=nvim' >> ~/.zshrc

# pyenv
brew install pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
source ~/.zshrc

# python
echo 'PATH=$(pyenv root)/shims:$PATH' >> ~/.zshrc
pyenv install 3.10.0
pyenv shell 3.10.0
python -m pip install --upgrade pip

# pyenv-virtualenvwrapper
brew install pyenv-virtualenvwrapper
echo 'export PYENV_VIRTUALENVWRAPPER_PREFER_PYENV="true"' >> ~/.zshrc
echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.zshrc
echo 'pyenv virtualenvwrapper_lazy' >> ~/.zshrc
source ~/.zshrc

# casks
brew install --cask iterm2 visual-studio-code docker rectangle

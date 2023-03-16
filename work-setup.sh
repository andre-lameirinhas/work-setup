#! /usr/bin/env bash
set -euo pipefail

# oh-my-zsh
# add if
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# brew
# add if
#xcode-select --install
# add if
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# starship
brew install starship
brew tap homebrew/cask-fonts && brew install --cask font-fira-code-nerd-font

# git
brew install git git-gui

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install --completion --no-update-rc

# z
curl -o ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh

# bat
brew install bat

# nvim
brew install neovim

# pyenv
brew install pyenv

# pyenv-virtualenvwrapper
brew install pyenv-virtualenvwrapper

# python
brew install xz
pyenv install 3.11.2
pyenv global 3.11.2
python -m pip install --upgrade pip setuptools

# casks
brew install --cask iterm2 visual-studio-code docker rectangle

cp .zshrc ~/.zshrc
source ~/.zshrc

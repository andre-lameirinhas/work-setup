#!/bin/bash

# brew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# ohmyzsh (plugins = git docker web-search)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# python stuff
brew install pyenv
pyenv install 3.10.0
pyenv shell 3.10.0
sudo pip install virtualenv
sudo pip install virtualenvwrapper

# z
curl -o ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
echo '. ~/z.sh' >> ~/.zshrc

# bat
brew install bat
echo 'alias cat=bat' >> ~/.zshrc

source ~/.zshrc

# casks
brew install --cask iterm2 visual-studio-code docker

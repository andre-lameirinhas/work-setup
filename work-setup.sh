#!/bin/bash

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# plugins = git docker web-search

brew update

brew install fzf
$(brew --prefix)/opt/fzf/install

brew install pyenv
pyenv install 3.10.0
pyenv shell 3.10.0

curl -o ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
echo '. ~/z.sh' >> ~/.zshrc

brew install bat
echo 'alias cat=bat' >> ~/.zshrc

source ~/.zshrc

brew install --cask visual-studio-code docker

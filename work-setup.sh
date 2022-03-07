#!/bin/bash

# ohmyzsh (plugins = git docker web-search)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# brew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
brew update

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# z
curl -o ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
echo '. ~/z.sh' >> ~/.zshrc

# bat
brew install bat
echo 'alias cat=bat' >> ~/.zshrc

#nvim
brew install neovim
echo 'alias vim=nvim' >> ~/.zshrc

# python stuff
brew install pyenv
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
source ~/.zshrc
source ~/.zprofile
pyenv install 3.10.0
pyenv shell 3.10.0
python -m pip install --upgrade pip
pip install virtualenv
pip install virtualenvwrapper

# poetry
curl -sSL https://install.python-poetry.org | python -
echo 'export PATH="~/.local/bin:$PATH"' >> ~/.zshrc

source ~/.zshrc

# casks
brew install --cask iterm2 visual-studio-code docker rectangle

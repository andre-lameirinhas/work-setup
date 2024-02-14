#! /usr/bin/env bash
set -euo pipefail

# oh-my-zsh
rm -rf ~/.oh-my-zsh
ZSH= sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# homebrew
if ! xcode-select -p > /dev/null; then
    xcode-select --install
fi
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# starship
brew install starship
brew tap homebrew/cask-fonts && brew install --cask font-fira-code-nerd-font

# git
brew install git git-gui
git config --global user.email "andre.lameirinhas@gmail.com"
git config --global pull.rebase true

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install --completion --no-update-rc

# z
curl -o ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh

# bat
brew install bat

# nvim
brew install neovim

# phpbrew
curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
chmod +x phpbrew.phar
sudo mv phpbrew.phar /usr/local/bin/phpbrew
phpbrew init

# pyenv
brew install pyenv
eval "$(pyenv init -)"

# pyenv-virtualenvwrapper
brew install pyenv-virtualenvwrapper

# python
brew install xz
pyenv install 3.12
pyenv global 3.12
python -m pip install --upgrade pip setuptools wheel

# casks
brew install --cask iterm2 visual-studio-code pycharm-ce docker rectangle opera

cp .zshrc ~/.zshrc
source ~/.zshrc

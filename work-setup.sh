#! /usr/bin/env zsh
set -eo pipefail

# oh-my-zsh
if [[ -z ${ZSH+x} ]]; then
    echo "Installing Oh My Zsh"
    # TODO: figure out how to prevent this command from exiting the script
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh already present, skipping..."
fi

# homebrew
if ! xcode-select -p > /dev/null; then
    xcode-select --install
fi

if [[ $(command -v brew) == "" ]]; then
    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "brew already present, updating..."
    brew update && brew upgrade
fi

# starship
brew install starship
brew tap homebrew/cask-fonts && brew install --cask font-fira-code-nerd-font

# git
brew install git git-gui
git config --global user.email "andre.lameirinhas@gmail.com"
git config --global pull.rebase true
git config --global rerere.enabled true
git config --global column.ui auto
git config --global branch.sort -committerdate

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# z
if [[ ! -f ~/z.sh ]]; then
    echo "Installing z"
    curl -o ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
else
    echo "z already present, skipping..."
fi

# bat
brew install bat

# nvim
brew install neovim

# phpbrew
brew install php
brew install autoconf pkg-config bzip2 zlib openssl@1.1 oniguruma readline libzip libxml2
curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
chmod +x phpbrew.phar
mv phpbrew.phar /usr/local/bin/phpbrew
phpbrew init
source ~/.phpbrew/bashrc
phpbrew lookup-prefix homebrew
phpbrew update
if phpbrew use 8.3.3; then
    echo "PHP 8.3.3 already installed, skipping..."
else
    echo "Installing PHP 8.3.3"
    phpbrew install --jobs $(sysctl -n hw.ncpu) 8.3.3 +default
fi
phpbrew switch 8.3.3

# pyenv
brew install pyenv
eval "$(pyenv init -)"

# pyenv-virtualenvwrapper
brew install pyenv-virtualenvwrapper

# python
brew install xz
pyenv install --skip-existing 3.12
pyenv global 3.12
python -m pip install --upgrade pip setuptools wheel

# poetry
curl -sSL https://install.python-poetry.org | python3 -

# ruby
brew install chruby ruby-install
ruby-install --no-reinstall ruby 3.3.0

# casks
#brew install --adopt --casks iterm2 visual-studio-code pycharm-ce docker rectangle opera

echo "Finished initial installation. Copying and sourcing .zshrc"
cp .zshrc ~/.zshrc
source ~/.zshrc

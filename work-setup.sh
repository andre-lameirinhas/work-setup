#!/bin/zsh
set -eo pipefail

if [[ $# > 0 && $1=="--dry-run" ]]; then
    echo "Running in dry run mode, no action"
    exit 0
fi

# oh-my-zsh
if [[ -z ${ZSH+x} ]]; then
    echo "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
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
brew install --cask font-fira-code-nerd-font
cp starship.toml ~/.config/starship.toml

# git
brew install git git-gui
brew install --cask git-credential-manager
brew install delta
brew install jesseduffield/lazygit/lazygit
cp lazygit.yml "$(lazygit -cd)/config.yml"

git config --global user.email "andre.lameirinhas@gmail.com"
git config --global user.name "André Lameirinhas"
git config --global pull.rebase true
git config --global rerere.enabled true
git config --global column.ui auto
git config --global branch.sort -committerdate
git config --global rebase.updateRefs true
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global merge.conflictStyle zdiff3
git config --global diff.colorMoved default

# dops (better docker ps)
brew tap mikescher/tap && brew install dops

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

# nvm
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'

# bat (cat clone with wings)
brew install bat

# fd (find alternative)
brew install fd

# eza (modern ls)
brew install eza

# nvim
brew install neovim

# gcloud
brew install google-cloud-sdk
gcloud components install gke-gcloud-auth-plugin

# watch
brew install watch

# glow (markdown reader)
brew install glow

# htop (process viewer)
brew install htop

# fastfetch
brew install fastfetch

# xan (CSV magician)
brew install xan

# rg (faster and better grep)
brew install ripgrep

# mole (macos maintenance)
brew install mole

source languages.sh

# casks
brew install --adopt --casks iterm2 visual-studio-code docker rectangle opera raycast meetingbar dbeaver-community bruno libreoffice vlc

echo "Finished initial installation. Generating and sourcing .zshrc"

sed -i "" "1s/^/PYTHON_INSTALLED=$PYTHON_INSTALLED\n/" zshrc
sed -i "" "1s/^/RUBY_INSTALLED=$RUBY_INSTALLED\n/" zshrc

awk 'BEGIN {cmd = "readlink -f scripts/coffee.sh" cmd | getline coffee_loc close(cmd)} /aliases/ {print; print "alias coffee=" coffee_loc; next}1' zshrc > ~/.zshrc

source ~/.zshrc

# add brew-upgrader to crontab
(crontab -l; echo "0 8 * * * $(readlink -f scripts/brew-upgrader.sh)") | sort -u | crontab -

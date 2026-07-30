#!/bin/zsh
set -eo pipefail

SKIP_LANGUAGES=false

for arg in "$@"; do
    case "$arg" in
        --dry-run)
            echo "Running in dry run mode, no action"
            exit 0
            ;;
        --skip-languages)
            SKIP_LANGUAGES=true
            ;;
    esac
done

# oh-my-zsh
if [[ ! -d "${ZSH:-$HOME/.oh-my-zsh}" ]]; then
    echo "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
else
    echo "Oh My Zsh already present, skipping..."
fi

# Xcode Command Line Tools (required for homebrew)
if ! xcode-select -p > /dev/null; then
    xcode-select --install
fi

# homebrew
export NONINTERACTIVE=1
if [[ $(command -v brew) == "" ]]; then
    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ $(uname -p) == "arm" ]]; then
        BIN_PATH="/opt/homebrew/bin"
    else
        BIN_PATH="/usr/local/bin"
    fi
    eval "$($BIN_PATH/brew shellenv)"
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
brew install lazygit
mkdir -p "$(lazygit -cd)" && cp lazygit.yml "$(lazygit -cd)/config.yml"

# gh (github cli)
brew install gh

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
brew trust mikescher/tap && brew tap mikescher/tap
brew install dops

# fzf
if ! command -v fzf &> /dev/null; then
    echo "Installing fzf"
    brew install fzf
    $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
else
    echo "fzf already installed, skipping..."
fi

# z
if [[ ! -f ~/z.sh ]]; then
    echo "Installing z"
    curl -o ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
else
    echo "z already present, skipping..."
fi

# claude code
if [[ $(command -v claude) == "" ]]; then
    echo "Installing Claude Code"
    curl -fsSL https://claude.ai/install.sh | bash
else
    echo "Claude Code already present, skipping..."
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

# rtk (token-optimized CLI proxy for Claude Code)
brew install rtk
rtk init -g --auto-patch

source languages.sh

# casks
# iterm2 - terminal emulator
# visual-studio-code - code editor
# docker - containerization platform
# rectangle - window management
# opera - web browser
# raycast - productivity launcher
# meetingbar - meeting reminders in the menu bar
# dbeaver-community - database management tool
# bruno - API client
# libreoffice - office suite
# vlc - media player
# whatcable - USB-C cable diagnostics menu bar app
# spotify - music streaming
brew install --adopt --casks iterm2 visual-studio-code docker rectangle opera raycast meetingbar dbeaver-community bruno libreoffice vlc darrylmorley/whatcable/whatcable spotify

echo "Finished initial installation. Generating and sourcing .zshrc"

sed -i "" "s/^GO_INSTALLED=.*/GO_INSTALLED=$GO_INSTALLED/" zshrc
sed -i "" "s/^PHP_INSTALLED=.*/PHP_INSTALLED=$PHP_INSTALLED/" zshrc
sed -i "" "s/^PYTHON_INSTALLED=.*/PYTHON_INSTALLED=$PYTHON_INSTALLED/" zshrc
sed -i "" "s/^RUBY_INSTALLED=.*/RUBY_INSTALLED=$RUBY_INSTALLED/" zshrc

awk 'BEGIN {cmd = "readlink -f scripts/coffee.sh" cmd | getline coffee_loc close(cmd)} /aliases/ {print; print "alias coffee=" coffee_loc; next}1' zshrc > ~/.zshrc

source ~/.zshrc

# add brew-upgrader to crontab
(crontab -l 2>/dev/null; echo "0 8 * * * $(readlink -f scripts/brew-upgrader.sh)") | sort -u | crontab -

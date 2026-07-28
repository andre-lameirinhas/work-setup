#!/bin/zsh
set -eo pipefail

# colors
Red="\033[0;31m"
Green="\033[0;32m"

# TODO:
# Tests missing:
# - git-gui
# - brew-upgrader.sh

source ~/.zshrc

error () {
    echo ${Red}Error: $1
    exit 1
}

[ ! -z $ZSH ] || error "oh-my-zsh env var is missing"
omz version >/dev/null
brew -v >/dev/null
starship -V >/dev/null
[[ "$(fc-match FiraCodeNerdFont)" == 'FiraCodeNerdFont-Regular.ttf: "FiraCode Nerd Font" "Regular"' ]] || error "firacode font not found"
[ -s ~/.config/starship.toml ] || error "starship config is missing"
git -v >/dev/null
git-credential-manager --version >/dev/null
lazygit -v >/dev/null
dops --version >/dev/null
fzf --version >/dev/null
[ -s ~/z.sh ] || error "z is missing"
nvm -v >/dev/null
bat -V >/dev/null
fd -V >/dev/null
eza -v >/dev/null
nvim -v >/dev/null
gcloud -v >/dev/null 2>&1
watch -v >/dev/null
glow -v >/dev/null
htop -V >/dev/null
fastfetch -v >/dev/null
xan --version >/dev/null
rg -V >/dev/null
mole --version >/dev/null
rtk --version >/dev/null

# casks
code -v >/dev/null
docker -v >/dev/null
vlc --version >/dev/null 2>&1
whatcable --version >/dev/null 2>&1
brew list --cask spotify >/dev/null || error "spotify not installed"
brew list --cask iterm2 >/dev/null || error "iterm2 not installed"
brew list --cask rectangle >/dev/null || error "rectangle not installed"
brew list --cask opera >/dev/null || error "opera not installed"
brew list --cask raycast >/dev/null || error "raycast not installed"
brew list --cask meetingbar >/dev/null || error "meetingbar not installed"
brew list --cask dbeaver-community >/dev/null || error "dbeaver-community not installed"
brew list --cask bruno >/dev/null || error "bruno not installed"
brew list --cask libreoffice >/dev/null || error "libreoffice not installed"

# built programs
coffee -v >/dev/null

# aliases
[[ "$(alias cat)" == "cat=bat" ]] || error "cat alias not set"
[[ "$(alias vim)" == "vim=nvim" ]] || error "vim alias not set"
[[ "$(alias lg)" == "lg=lazygit" ]] || error "lg alias not set"
[[ "$(alias ls)" == "ls='eza --icons -F -H --group-directories-first --git'" ]] || error "ls alias not set"

echo "${Green}All tests have passed!"

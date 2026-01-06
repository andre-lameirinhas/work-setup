#!/bin/zsh
set -eo pipefail

# colors
Red="\033[0;31m"
Green="\033[0;32m"

# TODO:
# Tests missing:
# - git-gui
# - casks
# - brew-upgrader.sh
# - python and tools
# - php and tools
# - ruby and tools

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

# casks
code -v >/dev/null
docker -v >/dev/null
vlc --version >/dev/null 2>&1

# built programs
coffee -v >/dev/null

# aliases
[[ "$(alias cat)" == "cat=bat" ]] || error "cat alias not set"
[[ "$(alias vim)" == "vim=nvim" ]] || error "vim alias not set"
[[ "$(alias lg)" == "lg=lazygit" ]] || error "lg alias not set"
[[ "$(alias ls)" == "ls='eza --icons -F -H --group-directories-first --git'" ]] || error "ls alias not set"

# languages
go version >/dev/null
php -v >/dev/null
ruby -v >/dev/null

echo "${Green}All tests have passed!"

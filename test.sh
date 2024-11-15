#!/bin/zsh
set -eo pipefail

# TODO:
# - fix commented tests
# - update README

# Tests missing:
# - alias
# - font-fira-code-nerd-font
# - git-gui
# - languages
# - casks

error () {
    echo $1
    exit 1
}

[ ! -z $ZSH ] || error "oh-my-zsh env var is missing"
brew -v >/dev/null
starship -V >/dev/null
[ -s ~/.config/starship.toml ] || error "starship config is missing"
git -v >/dev/null
git-credential-manager --version >/dev/null
lazygit -v >/dev/null
fzf --version >/dev/null
[ -s ~/z.sh ] || error "z is missing"
#nvm -v >/dev/null
bat -V >/dev/null
fd -V >/dev/null
nvim -v >/dev/null
#gcloud -v >/dev/null
watch -v >/dev/null
glow -v >/dev/null
htop -V >/dev/null
fastfetch -v >/dev/null
#coffee -v >/dev/null

echo "All tests have passed!"

#!/bin/zsh

# colors
Red="\033[0;31m"
Green="\033[0;32m"
NC="\033[0m"

# TODO:
# Tests missing:
# - brew-upgrader.sh

source ~/.zshrc

FAILURES=0

pass () {
    echo "$1 ${Green}passed${NC}"
}

fail () {
    echo "$1 ${Red}failed${NC}"
    FAILURES=$((FAILURES + 1))
}

check () {
    local desc=$1
    shift
    if "$@" >/dev/null 2>&1; then
        pass "$desc"
    else
        fail "$desc"
    fi
}

[ -n "$ZSH" ] && pass "oh-my-zsh env var" || fail "oh-my-zsh env var"
check "oh-my-zsh (omz)" omz version
check "brew" brew -v
check "starship" starship -V
[ -s ~/.config/starship.toml ] && pass "starship config" || fail "starship config"
[[ "$(fc-match FiraCodeNerdFont)" == 'FiraCodeNerdFont-Regular.ttf: "FiraCode Nerd Font" "Regular"' ]] && pass "firacode font" || fail "firacode font"
check "git" git -v
check "git gui" git gui --version
check "git-credential-manager" git-credential-manager --version
check "lazygit" lazygit -v
check "dops" dops --version
check "fzf" fzf --version
[ -s ~/z.sh ] && pass "z" || fail "z"
check "nvm" nvm -v
check "bat" bat -V
check "fd" fd -V
check "eza" eza -v
check "nvim" nvim -v
check "gcloud" gcloud -v
check "watch" watch -v
check "glow" glow -v
check "htop" htop -V
check "fastfetch" fastfetch -v
check "xan" xan --version
check "rg" rg -V
check "mole" mole --version
check "rtk" rtk --version

# casks
check "vscode (code)" code -v
check "docker" docker -v
check "vlc" vlc --version
check "whatcable" whatcable --version
check "spotify cask" brew list --cask spotify
check "iterm2 cask" brew list --cask iterm2
check "rectangle cask" brew list --cask rectangle
check "opera cask" brew list --cask opera
check "raycast cask" brew list --cask raycast
check "meetingbar cask" brew list --cask meetingbar
check "dbeaver-community cask" brew list --cask dbeaver-community
check "bruno cask" brew list --cask bruno
check "libreoffice cask" brew list --cask libreoffice

# built programs
COFFEE_BIN=$(alias coffee 2>/dev/null | sed 's/^coffee=//')
check "coffee" "$COFFEE_BIN" -v

# aliases
[[ "$(alias cat)" == "cat=bat" ]] && pass "cat alias" || fail "cat alias"
[[ "$(alias vim)" == "vim=nvim" ]] && pass "vim alias" || fail "vim alias"
[[ "$(alias lg)" == "lg=lazygit" ]] && pass "lg alias" || fail "lg alias"
[[ "$(alias ls)" == "ls='eza --icons -F -H --group-directories-first --git'" ]] && pass "ls alias" || fail "ls alias"

if [[ $FAILURES -gt 0 ]]; then
    echo "${Red}${FAILURES} test(s) failed${NC}"
    exit 1
else
    echo "${Green}All tests have passed!${NC}"
fi

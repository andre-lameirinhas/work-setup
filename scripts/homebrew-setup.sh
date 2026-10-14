#!/bin/zsh
set -eo pipefail

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

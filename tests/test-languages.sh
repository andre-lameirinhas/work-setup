#!/bin/zsh
set -eo pipefail

# colors
Red="\033[0;31m"
Green="\033[0;32m"

source ~/.zshrc

error () {
    echo ${Red}Error: $1
    exit 1
}

# go
if command -v go >/dev/null 2>&1; then
    go version >/dev/null || error "go check failed"
else
    echo "go not installed, skipping"
fi

# php
if command -v php >/dev/null 2>&1; then
    php -v >/dev/null || error "php check failed"
    pecl list | grep -qi xdebug || error "xdebug not installed"
    composer --version >/dev/null || error "composer check failed"
else
    echo "php not installed, skipping"
fi

# python
if command -v pyenv >/dev/null 2>&1; then
    pyenv version >/dev/null || error "pyenv check failed"
    pyenv commands | grep -q virtualenvwrapper || error "pyenv-virtualenvwrapper not installed"
    python -m pip --version >/dev/null || error "pip check failed"
    poetry --version >/dev/null || error "poetry check failed"
    [ -d "/Applications/PyCharm CE.app" ] || error "pycharm-ce not installed"
else
    echo "python not installed, skipping"
fi

# ruby
if command -v ruby-install >/dev/null 2>&1; then
    ruby-install --version >/dev/null || error "ruby-install check failed"
    type chruby >/dev/null 2>&1 || error "chruby not loaded"
    ruby -v >/dev/null || error "ruby check failed"
else
    echo "ruby not installed, skipping"
fi

echo "${Green}All language tests have passed!"

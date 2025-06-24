#!/bin/zsh
set -eo pipefail

echo "Install go?"
select yn in "Yes" "No"; do
    case $yn in
	Yes )
	    echo "Installing go"
        GO_INSTALLED=true

	    # go
	    brew install go

	    break;;
	No )
	    echo "Skipping go installation"
        GO_INSTALLED=false

	    break;;
    esac
done

echo "Install php (along with xdebug)?"
select yn in "Yes" "No"; do
    case $yn in
	Yes )
	    echo "Installing php and related tools"
        PHP_INSTALLED=true

	    # php
	    brew install php
	    if [[ ! $(pecl list | grep xdebug) ]]; then
	        pecl install xdebug
	    fi

	    break;;
	No )
	    echo "Skipping php installation"
        PHP_INSTALLED=false

	    break;;
    esac
done

echo "Install python (along with pyenv, virtualenvwrapper and poetry)?"
select yn in "Yes" "No"; do
    case $yn in
    Yes )
	    echo "Installing python and related tools"
	    PYTHON_INSTALLED=true

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
            
		# pycharm
		brew install --adopt --cask pycharm-ce

	    break;;
	No )
	    echo "Skipping python installation"
	    PYTHON_INSTALLED=false

	    break;;
    esac
done

echo "Install ruby (along with chruby and ruby-install)?"
select yn in "Yes" "No"; do
    case $yn in
    Yes )
	    echo "Installing ruby and related tools"
	    RUBY_INSTALLED=true

	    # ruby
	    brew install chruby ruby-install
	    ruby-install --no-reinstall ruby 3.3.0

	    break;;
	No )
	    echo "Skipping ruby installation"
	    RUBY_INSTALLED=false

	    break;;
    esac
done

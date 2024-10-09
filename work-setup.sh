#!/bin/zsh
set -eo pipefail

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
brew install jesseduffield/lazygit/lazygit

git config --global user.email "andre.lameirinhas@gmail.com"
git config --global pull.rebase true
git config --global rerere.enabled true
git config --global column.ui auto
git config --global branch.sort -committerdate
git config --global rebase.updateRefs true
git config --global alias.delete-merged-branches '!git switch master && git pull --prune && git branch --format '\''%(refname:short) %(upstream:track)'\'' | awk '\''$2 == "[gone]" { print $1 }'\'' | xargs -r git branch -D'
git config --global alias.update-branch '!git switch master; git pull; git switch -; git rebase master; git push -f'

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

# bat
brew install bat

# nvim
brew install neovim

# gcloud
brew install google-cloud-sdk
gcloud components install gke-gcloud-auth-plugin

# watch
brew install watch

# glow (markdown reader)
brew install glow

echo "Install php (along with xdebug)?"
select yn in "Yes" "No"; do
    case $yn in
	Yes )
	    echo "Installing php and related tools"

	    # php
	    brew install php
	    if [[ ! $(pecl list | grep xdebug) ]]; then
	        pecl install xdebug
	    fi

	    break;;
	No )
	    echo "Skipping php installation"

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

# casks
brew install --adopt --casks iterm2 visual-studio-code docker rectangle opera raycast meetingbar

echo "Finished initial installation. Generating and sourcing .zshrc"

sed -i "" "1s/^/PYTHON_INSTALLED=$PYTHON_INSTALLED\n/" .zshrc
sed -i "" "1s/^/RUBY_INSTALLED=$RUBY_INSTALLED\n/" .zshrc

awk 'BEGIN {cmd = "readlink -f coffee.sh" cmd | getline coffee_loc close(cmd)} /aliases/ {print; print "alias coffee=" coffee_loc; next}1' .zshrc > ~/.zshrc

source ~/.zshrc

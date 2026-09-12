#!/bin/zsh
set -eo pipefail

# this is needed to find omz
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# skip casks that self-update (e.g. Docker Desktop, Spotify) to avoid
# version-mismatch errors when their own auto-updater has already run
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1

# update oh-my-zsh
omz update

# check for Xcode Command Line Tools updates (install requires sudo, so we
# only report availability here rather than installing unattended)
CLT_UPDATE=$(softwareupdate --list 2>/dev/null | grep -i "Command Line Tools" || true)

if [[ -z $CLT_UPDATE ]]; then
    CLT_UPDATE="No Command Line Tools update available."
    echo $CLT_UPDATE
else
    echo "Command Line Tools update available (run 'softwareupdate --install' to apply):"
    echo "$CLT_UPDATE"
fi

# check for package updates
brew update -q

OUTDATED=$(brew outdated -v)

if [[ -z $OUTDATED ]]; then
    OUTDATED="No brew upgrades available."
fi

echo $OUTDATED

LOG_FILE="$HOME/brew_upgrade.log"

if [[ ! -f $LOG_FILE ]]; then
    touch $LOG_FILE
fi

# upgrade packages
brew upgrade -q
brew cleanup -q

date -R >> $LOG_FILE
echo "========================================" >> $LOG_FILE
echo $CLT_UPDATE >> $LOG_FILE
echo $OUTDATED >> $LOG_FILE
echo "======================================== \n" >> $LOG_FILE


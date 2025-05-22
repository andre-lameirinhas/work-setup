#!/bin/zsh
set -eo pipefail

# this is needed to find omz
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# update oh-my-zsh
omz update

# check for package updates
brew update -q

OUTDATED=$(brew outdated -v)

if [[ -z $OUTDATED ]]; then
    OUTDATED="No upgrades available."
    echo $OUTDATED
fi

LOG_FILE="$HOME/brew_upgrade.log"

if [[ ! -f $LOG_FILE ]]; then
    touch $LOG_FILE
fi

# upgrade packages
brew upgrade -q

date -R >> $LOG_FILE
echo "========================================" >> $LOG_FILE
echo $OUTDATED >> $LOG_FILE
echo "======================================== \n" >> $LOG_FILE


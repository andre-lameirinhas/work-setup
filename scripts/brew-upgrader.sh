#!/bin/zsh
set -eo pipefail

# update oh-my-zsh
omz update

# check for package updates
brew update -q

OUTDATED=$(brew outdated -v)

if [[ -z $OUTDATED ]]; then
    OUTDATED="No upgrades available."
fi

LOG_FILE="$HOME/brew_upgrade.log"

if [[ ! -f $LOG_FILE ]]; then
    touch $LOG_FILE
fi

# update packages
brew upgrade -q

date -R >> $LOG_FILE
echo "========================================" >> $LOG_FILE
echo $OUTDATED >> $LOG_FILE
echo "======================================== \n" >> $LOG_FILE


#!/bin/zsh
set -eo pipefail

brew update -q

OUTDATED=$(brew outdated -v)

if [[ -z $OUTDATED ]]; then
    OUTDATED="No upgrades available."
fi

LOG_FILE="$HOME/brew_upgrade.log"

if [[ ! -f $LOG_FILE ]]; then
    touch $LOG_FILE
fi

brew upgrade -q

date -R >> $LOG_FILE
echo "========================================" >> $LOG_FILE
echo $OUTDATED >> $LOG_FILE
echo "======================================== \n" >> $LOG_FILE


#!/bin/bash

NAME=${0##*/}

help() {
    echo
    echo "Usage: $NAME <command>"
    echo "Commands:"
    echo "  on      Turn coffee on"
    echo "  off     Turn coffee off"
    echo "  stat    Show current status"
    exit 0
}

if [[ $# -ne 1 ]]; then
    help
fi

CAFFEINE=$(screen -ls | grep coffee)

if [[ $1 == "on" ]]; then
    if [[ -z "$CAFFEINE" ]]; then
        screen -S coffee -dm caffeinate -d
        echo "coffee turned on"
    else
	echo "coffee is already on"
    fi
elif [[ $1 == "off" ]]; then
    if [[ ! -z "$CAFFEINE" ]]; then
	screen -X -S coffee quit
        echo "coffee turned off"
    else
	echo "coffee is already off"
    fi
elif [[ $1 == "stat" ]]; then
    [[ -z "$CAFFEINE" ]] && stat="off" || stat="on"
    echo "coffee is currently $stat"
else
    echo "Unknown command: $1"
    help
fi

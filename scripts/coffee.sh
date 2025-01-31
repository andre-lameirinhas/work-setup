#!/bin/bash

NAME=${0##*/}

intro() {
    echo "                                     ((((     "
    echo "            __  __                    ))))    "
    echo "           / _|/ _|                _ .---.    "
    echo "  ___ ___ | |_| |_ ___  ___       ( |\`---'|  "
    echo " / __/ _ \|  _|  _/ _ \/ _ \       \|     |   "
    echo "| (_| (_) | | | ||  __/  __/       : .___, :  "
    echo " \___\___/|_| |_| \___|\___|        \`-----'  "
    echo
    echo "A program to prevent your computer from sleeping."
}

help() {
    echo
    echo "Usage: $NAME <command>"
    echo "Commands:"
    echo "  on      Turn coffee on"
    echo "  off     Turn coffee off"
    echo "  stat    Show current status"
    exit 0
}

if [[ $# -eq 0 ]]; then
    intro
    help
elif [[ $# -ne 1 ]]; then
    echo "Too many arguments"
    help
fi

CAFFEINE=$(screen -ls | grep coffee)

if [[ $1 == "-v" ]]; then
    echo "coffee 0.1.0"
elif [[ $1 == "on" ]]; then
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

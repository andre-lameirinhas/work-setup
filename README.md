# Work Setup

## Description
Setup script for a new work environment

## Installation
Download contents:
```bash
curl -fsSL https://github.com/andre-lameirinhas/work-setup/archive/master.tar.gz | tar -xz
```
Run script:
```bash
cd work-setup-master && ./work-setup.sh && cd ..
```

## Manual Steps
After the installation script finishes successfully, execute these steps:
- In Opera Browser
  - Switch search engine to DuckDuckGo
  - Add Bitwarden extension
  - Enable VPN
- In iTerm2
  - Select Nerd Font: iTerm2 -> Settings... -> Profiles -> Text -> Font and then select `FiraCode Nerd Font Mono`
  - Change default window size: iTerm2 -> Settings... -> Profiles -> Window and then Columns = 200 and Rows = 50
- Setup MeetingBar with your calendar
- Add Raycast extensions
  - Toothpick
  - Kill Process
  - Spotify Player

## Testing
To test your setup, run this command:
```bash
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/andre-lameirinhas/work-setup/refs/heads/master/tests/test.sh)"
```

## Scripts
### Coffee  
Prevents computer from going to sleep. `coffee -h` for available commands.
### Brew Upgrader  
Upgrades brew packages and keeps a log in $HOME/brew_upgrade.log. Runs every day at 8am.
### Colors  
Stores colors to be used in scripts.

## TODO
- Fix coffee reference in test.sh when calling it via curl
- Add code to add brew-upgrader to crontab
- Add coffe image to coffee

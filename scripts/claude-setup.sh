#!/bin/zsh
set -eo pipefail

# claude code
if [[ $(command -v claude) == "" ]]; then
    echo "Installing Claude Code"
    curl -fsSL https://claude.ai/install.sh | bash
else
    echo "Claude Code already present, skipping..."
fi

# claude code statusline
brew install jq
mkdir -p ~/.claude
cp scripts/statusline-command.sh ~/.claude/statusline-command.sh
[ -f ~/.claude/settings.json ] || echo '{}' > ~/.claude/settings.json
tmp=$(mktemp)
jq '.statusLine = {type: "command", command: "bash ~/.claude/statusline-command.sh"}' ~/.claude/settings.json > "$tmp" && mv "$tmp" ~/.claude/settings.json

# rtk (token-optimized CLI proxy for Claude Code)
if [[ $(command -v rtk) == "" ]]; then
    echo "Installing rtk"
    brew install rtk
    rtk init -g --auto-patch
else
    echo "rtk already present, skipping..."
fi

# post-edit-check plugin (requires git, jq and perl; git and jq are installed earlier)
brew install perl
claude plugin marketplace add git@gitlab.molops.io:shahriar.hena/claude-postedit-check.git
claude plugin install post-edit-check@post-edit-check

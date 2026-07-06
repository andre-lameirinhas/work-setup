#!/bin/bash

set -e

EMAIL="andre.lameirinhas@gmail.com"
KEY_FILE="$HOME/.ssh/id_ed25519_github"
SSH_CONFIG="$HOME/.ssh/config"

echo "==> Setting up GitHub SSH key for $EMAIL"

# Generate key if it doesn't exist
if [[ -f "$KEY_FILE" ]]; then
    echo "==> Key already exists at $KEY_FILE, skipping generation"
else
    echo "==> Generating SSH key..."
    ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_FILE" -N ""
fi

# Add to ssh-agent
echo "==> Adding key to ssh-agent..."
eval "$(ssh-agent -s)" > /dev/null
ssh-add "$KEY_FILE"

# Add to ~/.ssh/config if not already present
if ! grep -q "Host github.com" "$SSH_CONFIG" 2>/dev/null; then
    echo "==> Adding GitHub entry to $SSH_CONFIG..."
    cat >> "$SSH_CONFIG" <<EOF

Host github.com
  IdentityFile $KEY_FILE
  AddKeysToAgent yes
EOF
    chmod 600 "$SSH_CONFIG"
else
    echo "==> GitHub entry already in $SSH_CONFIG, skipping"
fi

# Auth via gh CLI
if ! command -v gh &>/dev/null; then
    echo "==> Installing gh CLI..."
    brew install gh
fi

echo "==> Authenticating with GitHub (browser will open)..."
gh auth login --hostname github.com --git-protocol ssh --web

# Verify
echo "==> Verifying connection..."
ssh -T git@github.com 2>&1 || true

echo "==> Done! You can now clone and push to GitHub repos."

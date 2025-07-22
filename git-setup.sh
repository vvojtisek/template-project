#!/bin/bash

# Prompt for remote URL if not already set
read -p "Enter GitHub SSH repo URL (e.g. git@github.com:user/repo.git): " REMOTE_URL

if [[ "$REMOTE_URL" == https://github.com/* ]]; then
  USER_REPO=$(echo "$REMOTE_URL" | sed -E 's|https://github.com/||; s|.git$||')
  REMOTE_URL="git@github.com:${USER_REPO}.git"
  echo "✅ Converted HTTPS to SSH: $REMOTE_URL"
fi


# Git Identity (optional override)
git config user.name "Vladimír Vojtíšek"
git config user.email "vvojtisek@gmail.com"

# Git defaults
git config core.editor "code --wait"
git config color.ui auto
git config core.autocrlf input

# Init repo
git init

# Optional files
touch .gitignore
echo "# $(basename $(pwd))" > README.md

# --- SSH Key Setup and GitHub Registration ---

SSH_KEY="$HOME/.ssh/id_ed25519"

# Generate key if missing
if [ ! -f "$SSH_KEY" ]; then
  echo "🔐 No SSH key found, generating one..."
  ssh-keygen -t ed25519 -a 100 -C "vvojtisek@gmail.com" -f "$SSH_KEY"
fi

# Start SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

# Output the public key for GitHub registration
echo ""
echo "📋 Copy the SSH public key below and add it to GitHub:"
echo "   https://github.com/settings/ssh/new"
echo ""
cat "${SSH_KEY}.pub"
echo ""
echo "🔁 Press [ENTER] after you've added the key to GitHub..."
read -r

# First-time GitHub SSH confirmation
ssh -T git@github.com


# Add remote if provided
if [ -n "$REMOTE_URL" ]; then
  git remote add origin "$REMOTE_URL"
  git remote -v
fi

# First commit
git add .
git commit -m "Initial commit"

# Push if remote was added
if [ -n "$REMOTE_URL" ]; then
  git branch -M main
  git push -u origin main
fi

echo "✅ Git setup complete."

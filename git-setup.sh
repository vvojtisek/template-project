#!/bin/bash

# Prompt for repo name and remote
read -p "Enter remote Git URL (or leave blank to skip): " REMOTE_URL

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

# SSH Key setup check
if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "Generating new SSH key..."
  ssh-keygen -t ed25519 -a 100 -C "vvojtisek@gmail.com" -f ~/.ssh/id_ed25519
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  echo "🔐 Public key (add to GitHub):"
  cat ~/.ssh/id_ed25519.pub
else
  echo "SSH key already exists."
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi

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

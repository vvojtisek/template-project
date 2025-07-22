# Git Setup Guide

This guide walks you through configuring Git on your local machine and using a helper script to initialize repositories quickly. Follow these steps before starting a new project or cloning from GitHub.

---

## 1. Basic Git Configuration (Run Once)

```bash
git config --global user.name "Vladimír Vojtíšek"
git config --global user.email "vvojtisek@gmail.com"
git config --global core.editor "vim"
git config --global color.ui auto
git config --global core.autocrlf input
```

---

## 2. Git Setup Script

We use an automation script to simplify project setup.

### a. **Create the script file**

Create the file in your home directory:

```bash
cd ~
vim git-setup.sh
```

In `vim`, press `i` (insert mode), then **copy the contents of `git-setup.sh` from the repo** and paste it.

> This avoids keeping duplicate script logic in documentation. Always use the latest version from the repo.

Save and exit:

```vim
[Esc] → :wq → [Enter]
```

---

### b. **Make it executable**

```bash
chmod +x ~/git-setup.sh
```

---

## 3. Run the Script to Initialize a Project

```bash
mkdir ~/projects/my-new-repo
cd ~/projects/my-new-repo
~/git-setup.sh
```

* The script will prompt for a GitHub remote URL (optional).
* It will create `.gitignore`, a `README.md`, and handle your SSH key setup.
* If this is your first time using SSH with GitHub, follow the next section.

---

## 4. Add SSH Key to GitHub (First-Time Only)

1. **Display your public key:**

   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

2. **Copy the full output**

3. **Log into GitHub** and go to:

   * [Settings](https://github.com/settings/keys) → **SSH and GPG keys**
   * Click **“New SSH key”**

4. **Paste the key**

   * Title: anything descriptive (e.g. `MNOC laptop`)
   * Key type: leave as "Authentication Key"
   * Paste your copied key into the text box
   * Click **“Add SSH key”**

5. **Verify the connection:**

   ```bash
   ssh -T git@github.com
   ```

   You should see:

   ```
   Hi vvojtisek! You've successfully authenticated...
   ```

---

## 5. Optional: Run the Script from Anywhere

To simplify usage, add this to your `~/.bashrc` or `~/.zshrc`:

```bash
alias gitinit='~/git-setup.sh'
```

Then reload your shell:

```bash
source ~/.bashrc  # or ~/.zshrc
```

Now you can run:

```bash
gitinit
```

From any new project folder.

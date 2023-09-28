```markdown
# Git Setup Guide

## Configure Your Git Profile
```bash
# Set your name
git config --global user.name "vlad"

# Set your email
git config --global user.email "vvojtisek@gmail.com"
```

## Create or Clone a Repository
- To initialize a Git repository for an existing project, use:
  ```bash
  git init
  ```
- To clone a repository from a remote location:
  ```bash
  git clone <repository_url>
  ```

## Set Up a Remote Repository
- If you don't have one, create a remote repository on platforms like GitHub, GitLab, or Bitbucket.
- Add the remote repository to your local Git repository:
  ```bash
  git remote add origin <remote_repository_url>
  ```

## Test Passwordless Connection (SSH Keys)
1. Generate an SSH key:
   ```bash
   ssh-keygen -t ed25519 -a 100 -C "vvojtisek@gmail.com"
   ```

2. Add SSH key to the SSH agent:
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_rsa
   ```

3. Add the public key to your remote repository account (e.g., GitHub).

4. Test the connection:
   ```bash
   ssh -T git@github.com
   ```
   

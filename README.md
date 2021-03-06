# dotfiles

> Personal dotfiles

## Manual installation

0. Back up any dotfiles you may already have.
1. Clone this project to any directory.
2. Run `./bootstrap.sh`.

## Common tasks

This repo sets up a command alias `config` used for managing your dotfiles. It's a special alias for `git` that allows you to manage files outside of the bare git repo.

```bash
# Fetch changes
config fetch

# Pull the latest
config pull

# List all changes to tracked files
config status -uno

# Stage changes for a file; e.g. `.zshrc`
config add .zshrc

# Commit changes
config commit

# First push after setting up the repo
config push -u origin main

# Subsequent pushes
config push
```

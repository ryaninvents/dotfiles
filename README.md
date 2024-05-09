# dotfiles

> Personal dotfiles

## Manual installation

0. Back up any dotfiles you may already have.
1. MacOS: Run `xcode-select --install` if necessary to install Git.
2. Clone this project to any directory.
3. Run `./bootstrap.sh`.
4. In iTerm2, open Preferences
   - General tab » Preferences pane
   - Check the "Load preferences from a custom folder or URL" box
   - Set the location to `~/.prefs/iterm2`
   - Quit and reopen (settings should now be applied)
   - Go back to the preferences tab
   - Under "save changes", select "Automatically"
5. Set up your 1Password SSH key:
   - If you haven't already done so, [create an SSH key item in 1Password](https://developer.1password.com/docs/ssh/manage-keys/).
   - Configure the [1Password SSH agent](https://developer.1password.com/docs/ssh/agent).
6. If you are in a dev container, you may need to rebuild the container to make sure the SSH agent is set up correctly in .gitconfig.

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


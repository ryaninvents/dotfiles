#!/bin/bash
set -euo pipefail

# Based on Atlassian bare repo method https://www.atlassian.com/git/tutorials/dotfiles
# Uses sparse checkout to keep repo-only files (README, bootstrap) out of $HOME.

TARGET_DIR="${TARGET_DIR:-$HOME}"
BARE_REPO="$TARGET_DIR/.cfg"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKIP_FILE="$SCRIPT_DIR/../.sparse-checkout-ignored.txt"

config() {
  /usr/bin/git --git-dir="$BARE_REPO" --work-tree="$TARGET_DIR" "$@"
}

# --- Load skip list from config file ---
SKIP_FILES=()
if [ -f "$SKIP_FILE" ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    line="${line%%#*}"       # strip inline comments
    line="${line// /}"       # strip whitespace
    [ -z "$line" ] && continue
    SKIP_FILES+=("$line")
  done < "$SKIP_FILE"
fi

echo "Bootstrapping dotfiles..."
echo "Target directory: $TARGET_DIR"

# --- Detect fresh vs upgrade ---
UPGRADING=false
if [ -d "$BARE_REPO" ]; then
  UPGRADING=true
  echo "Bare repo already exists at $BARE_REPO — upgrading."
fi

if [ "$UPGRADING" = false ]; then
  # --- Fresh install ---
  echo "Creating bare repo at $BARE_REPO..."
  git clone --bare "$(git -C "$(dirname "$SCRIPT_DIR")" config --get remote.origin.url 2>/dev/null || echo "$(dirname "$SCRIPT_DIR")")" "$BARE_REPO"

  config config --local status.showUntrackedFiles no

  # Enable sparse checkout
  config config core.sparseCheckout true

  SPARSE_FILE="$BARE_REPO/info/sparse-checkout"
  echo '/*' > "$SPARSE_FILE"
  for f in "${SKIP_FILES[@]}"; do
    echo "!$f" >> "$SPARSE_FILE"
  done

  config fetch origin

  # Auto-detect default branch (DOTFILES_BRANCH overrides for testing)
  BRANCH="${DOTFILES_BRANCH:-$(config symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||' || true)}"
  [ -z "$BRANCH" ] && BRANCH="main"
  echo "Using branch: $BRANCH"

  config checkout "$BRANCH" 2>/dev/null || {
    echo ""
    echo "Checkout failed. This usually means files in $TARGET_DIR would be overwritten."
    echo "Back up or remove the conflicting files, then re-run this script."
    exit 1
  }

  config read-tree -mu HEAD

else
  # --- Upgrade: enable sparse checkout on existing bare repo ---
  BACKUP_DIR="$TARGET_DIR/.cfg-sparse-backup"

  # Back up files that will be excluded
  for f in "${SKIP_FILES[@]}"; do
    local_path="${f#/}"  # strip leading / for filesystem paths
    if [ -f "$TARGET_DIR/$local_path" ]; then
      mkdir -p "$BACKUP_DIR"
      cp "$TARGET_DIR/$local_path" "$BACKUP_DIR/$local_path"
      echo "Backed up $local_path"
    fi
  done

  config config --local status.showUntrackedFiles no

  # Enable sparse checkout
  config config core.sparseCheckout true

  SPARSE_FILE="$BARE_REPO/info/sparse-checkout"
  echo '/*' > "$SPARSE_FILE"
  for f in "${SKIP_FILES[@]}"; do
    echo "!$f" >> "$SPARSE_FILE"
  done

  # Apply sparse checkout (removes excluded files from worktree)
  config read-tree -mu HEAD

  # Restore backed-up files (they'll be untracked now)
  if [ -d "$BACKUP_DIR" ]; then
    for f in "${SKIP_FILES[@]}"; do
      local_path="${f#/}"  # strip leading / for filesystem paths
      if [ -f "$BACKUP_DIR/$local_path" ]; then
        cp "$BACKUP_DIR/$local_path" "$TARGET_DIR/$local_path"
        echo "Restored $local_path (now untracked)"
      fi
    done
    rm -rf "$BACKUP_DIR"
  fi
fi

echo "Bootstrapped."

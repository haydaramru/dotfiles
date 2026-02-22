#!/usr/bin/env bash
# chezmoi run_once script — installs zsh plugins via git clone
# This runs once per machine (chezmoi tracks state via filename hash)

set -euo pipefail

ZSH_PLUGINS="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
mkdir -p "$ZSH_PLUGINS"

clone_or_pull() {
  local repo="$1"
  local dest="$2"

  if [[ -d "$dest/.git" ]]; then
    echo "→ Updating $(basename "$dest")..."
    git -C "$dest" pull --quiet
  else
    echo "→ Cloning $(basename "$dest")..."
    git clone --depth=1 "$repo" "$dest"
  fi
}

clone_or_pull "https://github.com/romkatv/powerlevel10k.git" \
  "$ZSH_PLUGINS/powerlevel10k"

clone_or_pull "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
  "$ZSH_PLUGINS/zsh-syntax-highlighting"

clone_or_pull "https://github.com/zsh-users/zsh-autosuggestions.git" \
  "$ZSH_PLUGINS/zsh-autosuggestions"

echo "✓ Zsh plugins installed/updated."

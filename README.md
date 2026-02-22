# dotfiles (managed by chezmoi)

Multi-machine dotfiles: macOS, Ubuntu VPS, Raspberry Pi 5, Android (Termux).

## Quick start

### New machine
```bash
# Install chezmoi + apply dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply YOUR_GITHUB_USERNAME
```

### Termux (Android)
```bash
pkg install chezmoi git zsh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply YOUR_GITHUB_USERNAME
chsh -s zsh
```

## Structure

```
.chezmoi.toml.tmpl          → config (auto-detects OS, prompts email)
dot_zshrc.tmpl              → ~/.zshrc (templated per OS)
dot_p10k.zsh                → ~/.p10k.zsh (powerlevel10k config)
.chezmoiignore              → skip files per OS
run_once_install-zsh-plugins.sh → auto-clones zsh plugins
```

## Day-to-day usage

```bash
chezmoi edit ~/.zshrc        # edit source, not target
chezmoi diff                 # see pending changes
chezmoi apply                # apply changes
chezmoi cd                   # cd into source dir (for git commit/push)
```

## Adding a new tool to a specific machine

1. `chezmoi edit ~/.zshrc`
2. Wrap in template conditional:
   ```
   {{- if eq .chezmoi.os "darwin" }}
   # macOS only stuff
   {{- end }}
   ```
3. `chezmoi apply && chezmoi cd && git add -A && git commit -m "add tool" && git push`

## Per-machine overrides

Put machine-specific config that you don't want in chezmoi into `~/.zshrc.local`.
This file is sourced at the end of `.zshrc` and is NOT managed by chezmoi.

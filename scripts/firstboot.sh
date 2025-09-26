#!/usr/bin/env bash
set -euo pipefail

# CyberNEO first boot setup
# - Updates system
# - Copies bundled dotfiles (if present) into ~/.config
# - Installs Neovim plugins via lazy.nvim (LazyVim)
# - Preloads ML docker images
# - Sets up wallpapers

log() { printf "[firstboot] %s\n" "$*"; }

log "Updating system..."
sudo pacman -Syu --noconfirm

# Enable docker if installed
if command -v systemctl >/dev/null 2>&1 && command -v docker >/dev/null 2>&1; then
  log "Enabling docker service..."
  sudo systemctl enable docker || true
  if id -nG "$USER" | grep -qw docker; then
    log "User already in docker group."
  else
    log "Adding $USER to docker group (relogin required to take effect)."
    sudo usermod -aG docker "$USER" || true
  fi
fi

# Source dotfiles location candidates
DOTFILES_SOURCE=""
for CAND in "$HOME/dotfiles" \
            "$HOME/../root/dotfiles" \
            "/root/dotfiles" \
            "$HOME/CyberNeo/dotfiles"; do
  if [ -d "$CAND" ]; then DOTFILES_SOURCE="$CAND"; break; fi
done

if [ -n "$DOTFILES_SOURCE" ]; then
  log "Found dotfiles at: $DOTFILES_SOURCE"
  mkdir -p "$HOME/.config"
  # Hyprland/hyperland
  if [ -d "$DOTFILES_SOURCE/hyperland" ]; then
    mkdir -p "$HOME/.config/hypr"
    cp -r "$DOTFILES_SOURCE/hyperland/"* "$HOME/.config/hypr/"
  elif [ -d "$DOTFILES_SOURCE/hypr" ]; then
    mkdir -p "$HOME/.config/hypr"
    cp -r "$DOTFILES_SOURCE/hypr/"* "$HOME/.config/hypr/"
  fi
  # Waybar
  if [ -d "$DOTFILES_SOURCE/waybar" ]; then
    mkdir -p "$HOME/.config/waybar"
    cp -r "$DOTFILES_SOURCE/waybar/"* "$HOME/.config/waybar/"
  fi
  # Neovim
  if [ -d "$DOTFILES_SOURCE/nvim" ]; then
    mkdir -p "$HOME/.config/nvim"
    cp -r "$DOTFILES_SOURCE/nvim/"* "$HOME/.config/nvim/"
  fi
  # Zed
  if [ -d "$DOTFILES_SOURCE/zed" ]; then
    mkdir -p "$HOME/.config/zed"
    cp -r "$DOTFILES_SOURCE/zed/"* "$HOME/.config/zed/"
  fi
  # tmux
  if [ -f "$DOTFILES_SOURCE/tmux/.tmux.conf" ]; then
    cp "$DOTFILES_SOURCE/tmux/.tmux.conf" "$HOME/.tmux.conf"
  fi
  # xinitrc
  if [ -f "$DOTFILES_SOURCE/.xinitrc" ]; then
    cp "$DOTFILES_SOURCE/.xinitrc" "$HOME/.xinitrc"
  fi
else
  log "No bundled dotfiles found; skipping copy."
fi

# Install Neovim plugins if nvim is present
if command -v nvim >/dev/null 2>&1; then
  log "Syncing Neovim plugins (Lazy)..."
  nvim --headless "+Lazy! sync" +qa || true
fi

# Preload ML Docker images
if command -v docker >/dev/null 2>&1; then
  log "Pulling ML Docker images..."
  docker pull pytorch/pytorch:latest || true
  docker pull tensorflow/tensorflow:latest || true
fi

# Wallpapers
if [ -d "$HOME/assets/wallpapers" ]; then
  mkdir -p "$HOME/Pictures/Wallpapers"
  cp -r "$HOME/assets/wallpapers/"* "$HOME/Pictures/Wallpapers/" || true
fi

log "First boot tasks complete. You may need to re-login for docker group membership to apply."

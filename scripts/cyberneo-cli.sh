#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
CyberNEO CLI worker

Usage:
  ./scripts/cyberneo-cli.sh <profile> [action]

Profiles:
  minimal  (advanced, bare bones)
  full     (accessible, still opinionated)

Actions:
  install      Install packages for the selected profile (default)
  dotfiles     Copy dotfiles from this repo into ~/.config
  firstboot    Run scripts/firstboot.sh (includes update + dotfiles + docker pulls)

Examples:
  ./scripts/cyberneo-cli.sh minimal
  ./scripts/cyberneo-cli.sh full install
  ./scripts/cyberneo-cli.sh minimal dotfiles
  ./scripts/cyberneo-cli.sh full firstboot
USAGE
}

PROFILE=${1:-}
ACTION=${2:-install}

if [ -z "$PROFILE" ]; then
  usage
  exit 1
fi

case "$PROFILE" in
  minimal) PKG_FILE="baseline-packages.x86_64" ;;
  full) PKG_FILE="baseline-packages.full.x86_64" ;;
  *)
    echo "Unknown profile: $PROFILE" >&2
    usage
    exit 1
    ;;
 esac

REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

copy_dotfiles() {
  local src="$REPO_ROOT/dotfiles"
  if [ ! -d "$src" ]; then
    echo "[cli] dotfiles not found at $src" >&2
    exit 1
  fi

  mkdir -p "$HOME/.config"
  if [ -d "$src/hyperland" ]; then
    mkdir -p "$HOME/.config/hypr"
    cp -r "$src/hyperland/"* "$HOME/.config/hypr/"
  elif [ -d "$src/hypr" ]; then
    mkdir -p "$HOME/.config/hypr"
    cp -r "$src/hypr/"* "$HOME/.config/hypr/"
  fi
  if [ -d "$src/waybar" ]; then
    mkdir -p "$HOME/.config/waybar"
    cp -r "$src/waybar/"* "$HOME/.config/waybar/"
  fi
  if [ -d "$src/nvim" ]; then
    mkdir -p "$HOME/.config/nvim"
    cp -r "$src/nvim/"* "$HOME/.config/nvim/"
  fi
  if [ -d "$src/zed" ]; then
    mkdir -p "$HOME/.config/zed"
    cp -r "$src/zed/"* "$HOME/.config/zed/"
  fi
  if [ -f "$src/tmux/.tmux.conf" ]; then
    cp "$src/tmux/.tmux.conf" "$HOME/.tmux.conf"
  fi
  if [ -f "$src/.xinitrc" ]; then
    cp "$src/.xinitrc" "$HOME/.xinitrc"
  fi
}

case "$ACTION" in
  install)
    echo "[cli] Installing profile: $PROFILE"
    sudo pacman -Syu --needed - < "$REPO_ROOT/$PKG_FILE"
    ;;
  dotfiles)
    echo "[cli] Copying dotfiles"
    copy_dotfiles
    ;;
  firstboot)
    echo "[cli] Running firstboot"
    "$REPO_ROOT/scripts/firstboot.sh"
    ;;
  *)
    echo "Unknown action: $ACTION" >&2
    usage
    exit 1
    ;;
esac

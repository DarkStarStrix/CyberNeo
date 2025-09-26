# CyberNEO

CyberNEO is a lean, cyberpunk-flavored Arch setup using Hyprland, Waybar, and a pre-wired dev/ML stack. This repo contains baseline package lists, starter dotfiles, and a first-boot script to bootstrap a fresh install or ISO profile.

## What’s inside

- baseline-packages.x86_64 and baseline-packages.xas64 (spec name) — package set for Arch/pacman
- dotfiles/
  - hyperland/ (Hyprland config → installs to ~/.config/hypr)
  - hypr/ (same as above, for compatibility)
  - waybar/ (config + style)
  - nvim/ (Lazy.nvim bootstrap + sane defaults)
  - tmux/ (.tmux.conf)
  - zed/ (settings + keymap)
  - .xinitrc (exec Hyprland)
- scripts/firstboot.sh — applies dotfiles and preloads ML docker images
- assets/
  - wallpapers/ — drop images here
  - fonts/ — optional custom fonts

## Quickstart (on Arch)

1) Install baseline packages

Save this repo locally, then:

```bash
sudo pacman -Syu --needed - < baseline-packages.x86_64
```

2) Copy dotfiles for your user

```bash
mkdir -p ~/.config
cp -r dotfiles/nvim ~/.config/
cp -r dotfiles/waybar ~/.config/
# Prefer the spec folder name
mkdir -p ~/.config/hypr
cp -r dotfiles/hyperland/* ~/.config/hypr/
# Optional: tmux + zed
cp dotfiles/tmux/.tmux.conf ~/
mkdir -p ~/.config/zed && cp -r dotfiles/zed/* ~/.config/zed/
# Optional: startx support for Hyprland
cp dotfiles/.xinitrc ~/
```

3) First boot helper (optional)

```bash
chmod +x scripts/firstboot.sh
./scripts/firstboot.sh
```

4) Start Hyprland

```bash
startx
# ~/.xinitrc runs: exec Hyprland
```

## Notes

- Alacritty is the default terminal in the Hyprland config.
- Waybar will auto-start; wallpapers are picked from ~/Pictures/Wallpapers if present.
- Lazy.nvim is bootstrapped on first Neovim run; we keep it minimal so you can layer plugins.
- Docker service is enabled by the script; you may need to log out/in for docker group membership.

## ISO build (releng profile)

- Replace the releng packages list with this repo’s baseline-packages.x86_64 (or xas64 per spec).
- Place dotfiles under airootfs (e.g., /airootfs/root/dotfiles) and include scripts/firstboot.sh.
- Run the ArchISO build script (see Spec.md for steps).

## Troubleshooting

- No wallpaper? Put files under assets/wallpapers/ before running the script.
- Waybar JSON: this repo uses config.jsonc (comments allowed). If your waybar doesn’t support jsonc, remove comments or rename to config.
- Zed JSON: settings/keymaps are plain JSON (no comments).

## License

MIT. See LICENSE.

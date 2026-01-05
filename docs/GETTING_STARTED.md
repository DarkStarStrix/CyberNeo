# CyberNEO Getting Started

CyberNEO is in active development. This is the first public version. Expect sharp edges.

## Choose a profile

Minimal (advanced, bare bones):

```bash
sudo pacman -Syu --needed - < baseline-packages.x86_64
```

Full (accessible, still opinionated):

```bash
sudo pacman -Syu --needed - < baseline-packages.full.x86_64
```

## Apply dotfiles

```bash
mkdir -p ~/.config
cp -r dotfiles/hyperland/* ~/.config/hypr/
cp -r dotfiles/waybar ~/.config/
cp -r dotfiles/nvim ~/.config/
cp -r dotfiles/zed ~/.config/
cp dotfiles/tmux/.tmux.conf ~/
cp dotfiles/.xinitrc ~/
```

## First boot helper (optional)

```bash
chmod +x scripts/firstboot.sh
./scripts/firstboot.sh
```

## CLI worker

```bash
./scripts/cyberneo-cli.sh minimal install
./scripts/cyberneo-cli.sh full install
./scripts/cyberneo-cli.sh minimal dotfiles
```

## Start Hyprland

If you installed Xorg tools, you can use:

```bash
startx
```

Otherwise launch Hyprland from your display manager or TTY.

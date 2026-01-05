# CyberNEO v0.1 – Build Specification

Status: active development (first public version). Expect sharp edges.

CyberNEO is a lean, opinionated, cyberpunk-inspired OS built on Arch Linux with Hyprland, pre-configured developer tooling, and a streamlined ML/AI stack. This spec describes the full technical build process from scratch to ISO.

---

## Layer 0: Pre-Requirements

### Hardware
- USB stick ≥16GB
- Target machine with NVIDIA GPU

### Host Environment
- Existing Linux machine for ISO building
- Internet connection

### Tools Needed
- `archiso` (ISO building)
- `git`
- `vim` or `nvim`
- `dd` (for writing ISO)

### Repo Structure
```text
cyberneo-configs/
├── baseline-packages.xas64
├── dotfiles/
│   ├── hyperland/ (Hyprland config)
│   ├── tmux/
│   ├── nvim/
│   └── zed/
├── scripts/
│   └── firstboot.sh
└── assets/
    ├── wallpapers/
    └── fonts/
````

---

## Layer 1: Base Arch Installation

1. Download Arch ISO: [archlinux.org/download](https://archlinux.org/download/)
2. Write ISO to USB:

   ```bash
   sudo dd if=archlinux-YYYYMMDD.iso of=/dev/sdX bs=4M status=progress conv=fsync
   ```
3. Boot into live environment.
4. Partition and format:

   ```bash
   parted /dev/sdX
   mklabel gpt
   mkpart primary ext4 1MiB 100%
   set 1 boot on
   quit
   mkfs.ext4 /dev/sdX1
   mount /dev/sdX1 /mnt
   ```
5. Install base:

   ```bash
   pacstrap /mnt base linux linux-firmware vim git sudo
   genfstab -U /mnt >> /mnt/etc/fstab
   arch-chroot /mnt
   ```

---

## Layer 2: User & Networking Setup

1. Add CyberNEO user:

   ```bash
   useradd -m -G wheel -s /bin/bash cyberneo
   passwd cyberneo
   ```
2. Enable sudo for wheel group:

   ```bash
   EDITOR=vim visudo
   # Uncomment: %wheel ALL=(ALL) ALL
   ```
3. Enable networking:

   ```bash
   pacman -S networkmanager
   systemctl enable NetworkManager
   ```

---

## Layer 3: Baseline Packages

Create a profile list:

- Minimal (advanced): `baseline-packages.xas64`
- Full (accessible): `baseline-packages.full.xas64`

The profile files are the source of truth for package lists. In short:

- Minimal: Arch base, Hyprland + Waybar, CLI essentials, and the ML stack.
- Full: Minimal plus audio, XWayland, file manager, browser, and shell polish.

Install:

```bash
pacman -Syu --needed - < baseline-packages.xas64
# or
pacman -Syu --needed - < baseline-packages.full.xas64
```

---

## Layer 4: Hyprland + GUI Config

1. Install Hyprland:

   ```bash
   pacman -S hyprland swaybg waybar wl-clipboard grim slurp
   ```
2. Xinit:

   ```bash
   echo "exec Hyprland" > ~/.xinitrc
   ```
3. Configure `~/.config/hypr/hyprland.conf` (tiling, keybinds, neon theme).
4. Add wallpapers to `~/assets/wallpapers/`.

---

## Layer 5: Development Environment

### NeoVim + LazyVim

```bash
git clone https://github.com/craftyourdotfiles/LazyVim.git ~/.config/nvim
```

### Zed

* Download the latest release
* Place configs under `dotfiles/zed/`

### Tmux

* Add `.tmux.conf` with keybindings + session management

### Docker & CI/CD

```bash
systemctl enable docker
usermod -aG docker cyberneo
```

---

## Layer 6: ML & AI Environment

### Drivers

```bash
pacman -S nvidia nvidia-utils cuda cudnn
```

### Python & UV

```bash
python -m pip install --upgrade pip
pip install uv torch tensorflow
```

### Preload ML Docker Images

```bash
docker pull pytorch/pytorch:latest
docker pull tensorflow/tensorflow:latest
```

---

## Layer 7: Aesthetics & Lifestyle

* Wallpapers → `~/assets/wallpapers/`
* Fonts: JetBrains Mono, Fira Code
* Icons: Papirus
* Apps:

  ```bash
  pacman -S mpv feh zathura
  ```

---

## Layer 8: First-Boot Automation

`scripts/firstboot.sh`:

```bash
#!/bin/bash
# Update system
sudo pacman -Syu --noconfirm

# Pull configs
git clone https://github.com/yourusername/cyberneo-dotfiles.git ~/.config

# Install Neovim plugins
nvim +PlugInstall +qall

# Preload ML Docker containers
docker pull pytorch/pytorch:latest
docker pull tensorflow/tensorflow:latest

# Wallpapers
mkdir -p ~/Pictures/Wallpapers
cp -r ~/assets/wallpapers/* ~/Pictures/Wallpapers/
```

Make executable:

```bash
chmod +x ~/scripts/firstboot.sh
```

---

## Layer 9: ISO Build

1. Install `archiso`:

   ```bash
   pacman -S archiso
   ```
2. Copy default profile:

   ```bash
   cp -r /usr/share/archiso/configs/releng/ ~/cyberneo-iso
   cd ~/cyberneo-iso
   ```
3. Replace `packages.x86_64` with `baseline-packages.xas64`.
4. Add `dotfiles` + `scripts/firstboot.sh` under `/airootfs/root/`.
5. Build ISO:

   ```bash
   sudo ./build.sh -v
   ```
6. Result → `out/archlinux-YYYYMMDD.iso`

---

## Layer 10: Testing

* Boot ISO in VM/USB
* Verify:

  * Hyprland loads correctly
  * Tmux sessions work
  * NeoVim + Zed configs functional
  * CUDA + PyTorch/TensorFlow detect GPU
  * Docker containers run
  * Wallpapers & aesthetics applied

---

## Notes

* Arch is rolling: pin critical ML packages if needed
* Use layered repo structure for reproducibility
* Keep repo private until ISO v1 is stable

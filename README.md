# CyberNEO

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE) [![Arch Linux](https://img.shields.io/badge/distro-Arch-blue.svg)](https://archlinux.org/) [![Release](https://img.shields.io/github/v/release/DarkStarStrix/CyberNeo)](https://github.com/DarkStarStrix/CyberNeo/releases)

CyberNEO is a custom Arch-based Linux distribution tailored for developers, machine learning engineers, and hackers seeking a fast, minimal, and stylish operating system.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Download ISO](#download-iso)
  - [Virtual Machine](#virtual-machine)
  - [Bare Metal](#bare-metal)
- [Usage](#usage)
- [Configuration](#configuration)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Features

- Fast, Arch-based minimal installation
- Pre-configured development environment
  - Python, Node.js, Rust, Go toolchains
  - GPU acceleration support (CUDA, ROCm)
- Lightweight window manager (i3wm) with custom themes
- Zsh with Oh My Zsh and useful plugins
- Tmux configured for productivity
- Custom scripts for system maintenance and updates
- Stylish terminal (Powerlevel10k prompt, icons)

## Requirements

- x86_64 architecture
- Minimum 2 GB RAM (4 GB recommended)
- 20 GB free disk space
- UEFI/BIOS with virtualization support (optional)

## Installation

### Download ISO

1. Visit the [Releases](https://github.com/DarkStarStrix/CyberNeo/releases) page.
2. Download the latest `.iso` file.
3. Verify the checksum:
   ```bash
   sha256sum CyberNEO-<version>.iso
   # Compare with published checksum
   ```

### Virtual Machine

1. Create a new VM with 2 CPU cores and 4 GB RAM.
2. Attach the downloaded ISO as the boot medium.
3. Boot the VM and follow the guided installer.

### Bare Metal

1. Create a bootable USB:
   ```bash
   sudo dd if=CyberNEO-<version>.iso of=/dev/sdX bs=4M status=progress && sync
   ```
2. Boot from the USB drive.
3. Follow the on-screen installer prompts.

## Usage

- Log in with the default user `neo` (password: `cyberneo`).
- Update the system:
  ```bash
  sudo pacman -Syu
  ```
- Launch the window manager:
  ```bash
  startx
  ```

## Configuration

- Edit `~/.config/i3/config` to customize keybindings and layouts.
- Themes and colors are in `~/.config/polybar/` and `~/.config/rofi/`.
- Zsh aliases are in `~/.zshrc`.

## Customization

- Add your favorite dotfiles or install additional software with `pacman`.
- Enable AUR support with an AUR helper (e.g., `yay`).

## Troubleshooting

- For network issues, check `systemctl status NetworkManager`.
- For graphics problems, see `/var/log/Xorg.0.log`.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/my-feature`.
3. Commit your changes: `git commit -m "Add my feature"`.
4. Push to your branch: `git push origin feature/my-feature`.
5. Open a pull request.

Please ensure your code follows the existing style and includes documentation where necessary.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Arch Linux
- i3 Window Manager
- Oh My Zsh
- Powerlevel10k
- Polybar


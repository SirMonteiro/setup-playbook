# My Arch Linux Workstation Setup

This Ansible playbook automates the configuration of my personal Arch Linux workstation. It is designed to be run on a fresh Arch installation to quickly bring it to a fully configured state.

## Features

This playbook will:
- Update the system and install essential command-line tools.
- Configure the [Chaotic-AUR](https://aur.chaotic.cx/) repository for pre-compiled packages.
- Install and configure `paru` as the AUR helper.
- Install a complete Hyprland desktop environment with all necessary components.
- Install a curated list of desktop and development applications.
- Set Zsh as the default shell.
- Install `rustup` and `mise` for managing development toolchains.
- Deploy my personal dotfiles from [sirmonteiro/dotfiles](https://github.com/sirmonteiro/dotfiles) using `chezmoi`.

## Bootstrap & Run

To run this playbook on a new machine, execute the following command. It will handle all dependencies and execute the playbook.

**Important:** You must first upload this repository to your GitHub account and replace the placeholder URL in the `setup.sh` script.

```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/your-username/my-arch-playbook/main/setup.sh](https://raw.githubusercontent.com/your-username/my-arch-playbook/main/setup.sh))"

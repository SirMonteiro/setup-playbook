#!/bin/bash
#
# This script bootstraps the setup of a new Arch Linux machine by:
# 1. Prompting for the sudo password.
# 2. Updating the system and installing essential prerequisites.
# 3. Installing Ansible.
# 4. Cloning the playbook repository.
# 5. Running the main Ansible playbook.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
REPO_URL="https://github.com/your-username/my-arch-playbook.git" # IMPORTANT: Change this to your repository URL
WORK_DIR="/tmp/my-arch-playbook"

# --- Functions ---
prompt_sudo() {
    echo "This script requires sudo access to install packages and configure the system."
    if [ "$(id -u)" -eq 0 ]; then
        echo "Script is already running as root. No need for sudo password."
        PASSWORD=""
        return
    fi

    local sudo_correct=1
    until [ $sudo_correct -eq 0 ]; do
        read -s -p "Enter sudo password for $USER: " PASSWORD
        echo ""
        echo "$PASSWORD" | sudo -S -k whoami &>/dev/null
        sudo_correct=$?

        if [ $sudo_correct -ne 0 ]; then
            echo "Sudo password incorrect, please try again."
        fi
    done
}

# --- Main Execution ---
prompt_sudo

echo "==> Synchronizing package databases and updating system..."
echo "$PASSWORD" | sudo -S pacman -Syyu --noconfirm

echo "==> Installing prerequisites (git, python, pip)..."
echo "$PASSWORD" | sudo -S pacman -S --noconfirm --needed git python python-pip ansible

# Ensure ~/.local/bin is in the PATH for the current script execution
export PATH="$HOME/.local/bin:$PATH"

echo "==> Cloning the playbook repository to $WORK_DIR..."
rm -rf "$WORK_DIR"
git clone "$REPO_URL" "$WORK_DIR"

echo "==> Running the Ansible playbook..."
ansible-galaxy install -r "$WORK_DIR/requirements.yml"
# Use -e to pass the sudo password as an extra variable to Ansible
ansible-playbook -c local -i 127.0.0.1, -e "ansible_become_pass='$PASSWORD'" "$WORK_DIR/main.yml"

echo "==> Workstation setup complete!"

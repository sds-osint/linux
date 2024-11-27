#!/bin/bash

# Define functions for each package manager
update_apt() {
    echo "Detected apt (Debian/Ubuntu-based). Updating system..."
    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean
}

update_dnf() {
    echo "Detected dnf (Fedora-based). Updating system..."
    sudo dnf upgrade --refresh -y
}

update_yum() {
    echo "Detected yum (CentOS/RHEL-based). Updating system..."
    sudo yum update -y
}

update_zypper() {
    echo "Detected zypper (openSUSE-based). Updating system..."
    sudo zypper refresh && sudo zypper update -y
}

update_pacman() {
    echo "Detected pacman (Arch-based). Updating system..."
    sudo pacman -Syu --noconfirm
}

update_apk() {
    echo "Detected apk (Alpine-based). Updating system..."
    sudo apk update && sudo apk upgrade
}

update_emerge() {
    echo "Detected emerge (Gentoo-based). Updating system..."
    sudo emerge --sync && sudo emerge --update --deep --newuse @world
}

update_flatpak() {
    echo "Checking for Flatpak updates..."
    flatpak update -y
}

update_snap() {
    echo "Checking for Snap updates..."
    sudo snap refresh
}

# Detect package manager and call the appropriate function
if command -v apt > /dev/null; then
    update_apt
elif command -v dnf > /dev/null; then
    update_dnf
elif command -v yum > /dev/null; then
    update_yum
elif command -v zypper > /dev/null; then
    update_zypper
elif command -v pacman > /dev/null; then
    update_pacman
elif command -v apk > /dev/null; then
    update_apk
elif command -v emerge > /dev/null; then
    update_emerge
else
    echo "No recognized package manager found!"
    exit 1
fi

# Optional: Check for Flatpak and Snap updates
if command -v flatpak > /dev/null; then
    update_flatpak
fi

if command -v snap > /dev/null; then
    update_snap
fi

echo "System update completed!"
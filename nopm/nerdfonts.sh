#!/usr/bin/env bash

get_file_name() {
    arch=$(get_architecture)
    [[ "$arch" == "aarch64" ]] && arch="arm64"
    echo "nvim-linux-$arch.appimage"
}

install_font() {
    local version="$1"
    local font_name="$2"

    curl -fLo "$font_name.tar.xz" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$font_name.tar.xz"
    sudo mkdir "/usr/share/fonts/$font_name"
    sudo tar -xf "$font_name.tar.xz" -C "/usr/share/fonts/$font_name"
}

remove_font() {
    local font_name="$1"
    sudo rm -rf "/usr/share/fonts/$font_name"
}

install() {
    local version="$1"

    install_font $1 "CodeNewRoman"
    install_font $1 "Hack"
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    remove_font "CodeNewRoman"
    remove_font "Hack"
}

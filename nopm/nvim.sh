#!/usr/bin/env bash

install() {
    local app_path="$1"

    safe_run rm ./nvim.appimage
    curl -LR https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage -o nvim.appimage
    chmod u+x ./nvim.appimage
    ask_sudo mv nvim.appimage "$1" -f
}

update() {
    local app_path="$1"

    install $1
}

get_installed_version() {
    local app=$1

    $1 --version | grep -m2 '^NVIM' | awk '{print $2}' | tr -d 'v'
}

get_latest_version() {
    curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    local app_path="$1"

    ask_sudo rm "$app_path"
}

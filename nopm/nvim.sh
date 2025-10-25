#!/usr/bin/env bash

install() {
    local app_path="$1"
    local version=$(ensure_v_prefix $2)

    rm -f ./nvim.appimage || echo
    curl -LRs "https://github.com/neovim/neovim/releases/download/$version/nvim-linux-x86_64.appimage" -o nvim.appimage
    chmod u+x ./nvim.appimage
    ask_sudo mv nvim.appimage "$1" -f
}

update() {
    local app_path="$1"
    local version="$2"

    install $app_path $version
}

get_installed_version() {
    local app=$1

    $1 --version | grep -m2 '^NVIM' | awk '{print $2}' | tr -d 'v' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    local app_path="$1"

    ask_sudo rm "$app_path"
}

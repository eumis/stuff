#!/usr/bin/env bash

get_file_name() {
    arch=$(get_architecture)
    [[ "$arch" == "aarch64" ]] && arch="arm64"
    echo "nvim-linux-$arch.appimage"
}

install() {
    local version="$1"

    rm -f ./nvim.appimage || echo
    curl -LRs "https://github.com/neovim/neovim/releases/download/v$version/$(get_file_name)" -o nvim.appimage
    chmod u+x ./nvim.appimage
    sudo mv nvim.appimage "/usr/local/bin/nvim" -f
    ln -sf ~/stuff/nvim ~/.config
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    nvim --version 2>/dev/null | grep -m2 '^NVIM' | awk '{print $2}' | tr -d 'v' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/nvim" || echo
}

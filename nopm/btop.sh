#!/usr/bin/env bash

cleanup() {
    rm -rf ./btop || echo
    rm -f btop.tbz || echo
}

get_file_name() {
    arch=$(get_architecture)

    echo "btop-$arch-linux-musl.tbz"
}

install() {
    local version="$1"

    cleanup
    curl -LRs "https://github.com/aristocratos/btop/releases/download/v$version/$(get_file_name)" -o btop.tbz
    tar -xf btop.tbz
    sudo cp btop/bin/btop "/usr/local/bin/btop" -f
    cleanup
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    btop -v 2>/dev/null | awk '{print $3}' | sed -r 's/\x1B\[[0-9;]*[A-Za-z]//g' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/aristocratos/btop/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/btop" || echo
}

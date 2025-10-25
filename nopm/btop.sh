#!/usr/bin/env bash

cleanup() {
    rm -rf ./btop || echo
    rm -f btop.tbz || echo
}

install() {
    local app_path="$1"
    local version=$(ensure_v_prefix $2)

    cleanup
    curl -LRs "https://github.com/aristocratos/btop/releases/download/$version/btop-x86_64-linux-musl.tbz" -o btop.tbz
    tar -xf btop.tbz
    ask_sudo cp btop/bin/btop "$1" -f
    cleanup
}

update() {
    local app_path="$1"
    local version="$2"

    install $app_path $version
}

get_installed_version() {
    local app=$1

    $1 --version | rg version | awk '{print $3}' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/aristocratos/btop/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    local app_path="$1"

    echo "$app_path"

    ask_sudo rm "$app_path"
}

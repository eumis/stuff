#!/usr/bin/env bash

get_file_name() {
    arch=$(get_architecture)
    case "$arch" in
        aarch64) echo "yt-dlp_linux_aarch64" ;;
        *) echo "yt-dlp_linux" ;;
    esac
}

install() {
    local app_path="$1"
    local version="$2"

    rm -f ./nvim.appimage || echo
    curl -LRs "https://github.com/yt-dlp/yt-dlp/releases/download/$version/$(get_file_name)" -o yt-dlp
    chmod u+x ./yt-dlp
    ask_sudo mv yt-dlp "$1" -f
}

update() {
    local app_path="$1"
    local version="$2"

    install $app_path $version
}

get_installed_version() {
    local app=$1

    $1 --version || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/yt-dlp/yt-dlp/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    local app_path="$1"

    ask_sudo rm "$app_path"
}

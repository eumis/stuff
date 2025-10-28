#!/usr/bin/env bash

get_file_name() {
    arch=$(get_architecture)
    case "$arch" in
        aarch64) echo "yt-dlp_linux_aarch64" ;;
        *) echo "yt-dlp_linux" ;;
    esac
}

install() {
    local version="$1"

    rm -f ./yt-dlp || echo
    curl -LRs "https://github.com/yt-dlp/yt-dlp/releases/download/$version/$(get_file_name)" -o yt-dlp
    chmod u+x ./yt-dlp
    sudo mv yt-dlp "/usr/local/bin/yt-dlp" -f
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    yt-dlp --version 2>/dev/null || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/yt-dlp/yt-dlp/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/yt-dlp"
}

#!/usr/bin/env bash

install() {
    local version="$1"
    local download_url=$(get_download_url $version)

    echo "installing muscore $download_url"

    rm -f ./muscore.appimage || echo
    curl -LRs "$download_url" -o muscore.appimage
    chmod u+x ./muscore.appimage
    sudo mv muscore.appimage "/usr/local/bin/muscore" -f
}

get_download_url() {
    local version="$1"
    curl -s https://api.github.com/repos/musescore/MuseScore/releases | jq -r ".[] | select(.tag_name == \"v$version\") | .assets[] | select(.name | endswith(\"x86_64.AppImage\")) | .browser_download_url"
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    muscore --version 2>&1 | tail -n 1 | awk '{print $2}'
}

get_latest_version() {
    curl -s https://api.github.com/repos/musescore/MuseScore/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/muscore" || echo
}

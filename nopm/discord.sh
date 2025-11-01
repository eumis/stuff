#!/usr/bin/env bash

install() {
    local version="$1"

    rm -f ./discord.deb || echo
    curl -LRs "https://discord.com/api/download?platform=linux" -o discord.deb
    sudo apt install ./discord.deb
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    apt list discord 2>/dev/null | grep -m2 'discord' | awk '{print $2}' || echo
}

get_latest_version() {
    curl -s 'https://discord.com/api/updates/stable?platform=linux' | jq -r '.name'
}

uninstall() {
    sudo apt uninstall discord || echo
}

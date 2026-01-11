#!/usr/bin/env bash

install() {
    local version="$1"

    rm -f ./telegram.tar.xz || echo
    rm -rf ./Telegram || echo
    curl -LRs "https://telegram.org/dl/desktop/linux" -o telegram.tar.xz
    tar -xf telegram.tar.xz
    sudo cp ./Telegram/Telegram /usr/local/bin/telegram
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    echo
}

get_latest_version() {
    echo
}

uninstall() {
    sudo rm /usr/local/bin/telegram || echo
}

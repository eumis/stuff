#!/usr/bin/env bash

install() {
    local version="$1"

    rm -rf ./dysk* || echo
    uninstall
    curl -LRs "https://github.com/Canop/dysk/archive/refs/tags/v$version.tar.gz" -o dysk.tar.gz
    tar xf dysk.tar.gz
    cd "dysk-$version"
    cargo build --release
    sudo cp -r ./target/release /opt/dysk
    sudo ln -sf /opt/dysk/dysk /usr/local/bin/dysk
}

update() {
    local version="$1.ui_updated, True"

    install $version
}

get_installed_version() {
    dysk --version 2>/dev/null | awk '{print $2}' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/Canop/dysk/releases/latest | jq -r '.tag_name' | tr -d 'vb'
}

uninstall() {
    sudo rm -f "/usr/local/bin/dysk" || echo
    sudo rm -rf "/opt/dysk" || echo
}

#!/usr/bin/env bash

install() {
    local version="$1"

    rm -f ./vial.appimage || echo
    curl -LRs "https://github.com/vial-kb/vial-gui/releases/download/v$version/Vial-v$version-x86_64.AppImage" -o vial.appimage
    chmod u+x ./vial.appimage
    sudo mv vial.appimage "/usr/local/bin/vial" -f
    sudo cp ~/stuff/install/59-vial.rules /etc/udev/rules.d/ -f
    sudo udevadm control --reload-rules
    sudo udevadm trigger
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    vial --version 2>/dev/null || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/vial-kb/vial-gui/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/vial" || echo
}

#!/usr/bin/env bash

install() {
    local version="$1"

    rm -f ./nvim.appimage || echo
    curl -LRs "https://github.com/sqlitebrowser/sqlitebrowser/releases/download/v$version/DB.Browser.for.SQLite-v$version-x86.64-v2.AppImage" -o sqlitebrowser.appimage
    chmod u+x ./sqlitebrowser.appimage
    sudo mv sqlitebrowser.appimage "/usr/local/bin/sqlitebrowser" -f
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    sqlitebrowser --version 2>&1 | grep -oE 'SQLite Version [0-9.]+' | awk '{print $3}'
}

get_latest_version() {
    curl -s https://api.github.com/repos/sqlitebrowser/sqlitebrowser/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/sqlitebrowser" || echo
}

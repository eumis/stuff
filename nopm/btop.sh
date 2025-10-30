#!/usr/bin/env bash

cleanup() {
    rm -rf ./btop || echo
    rm -f btop.tbz || echo
    rm -f btop4win-x64.zip || echo
}

install() {
    local version="$1"
    local os=$(get_os)
    local arch=$(get_architecture)

    cleanup
    if [[ $os == "linux" ]]; then
        curl -LRs "https://github.com/aristocratos/btop/releases/download/v$version/btop-$arch-linux-musl.tbz" -o btop.tbz
        tar -xf btop.tbz
        sudo cp btop/bin/btop "/usr/local/bin/btop" -f
    else
        curl -LRs "https://github.com/aristocratos/btop4win/releases/download/v$version/btop4win-LHM-x64.zip" -o "btop.zip"
        unzip btop.zip
        mv btop4win/btop4win.exe btop4win/btop.exe
        mv btop4win "/c/tools/btop" -f
    fi
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
    local os=$(get_os)
    if [[ $os == "linux" ]]; then
        curl -s https://api.github.com/repos/aristocratos/btop/releases/latest | jq -r '.tag_name' | tr -d 'v'
    else
        curl -s https://api.github.com/repos/aristocratos/btop4win/releases/latest | jq -r '.tag_name' | tr -d 'v'
    fi
}

uninstall() {
    local os=$(get_os)
    if [[ $os == "linux" ]]; then
        sudo rm "/usr/local/bin/btop" || echo
    else
        rm -rf "/c/tools/btop" || echo
    fi
}

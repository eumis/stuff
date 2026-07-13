#!/usr/bin/env bash

cleanup() {
    rm -rf zoxide || echo
    rm -f zoxide.tar.gz || echo
}

install() {
    local version="$1"
    local os=$(get_os)
    local arch=$(get_architecture)
    case "$arch" in
        aarch64) arch="arm64" ;;
        x86_64) arch="x86_64" ;;
    esac

    cleanup
    curl -LRs "https://github.com/ajeetdsouza/zoxide/releases/download/v$version/zoxide-$version-$arch-unknown-linux-musl.tar.gz" -o zoxide.tar.gz
    mkdir zoxide
    tar -xf zoxide.tar.gz --directory zoxide
    sudo cp zoxide/zoxide "/usr/local/bin/zoxide" -f
    sudo cp zoxide/man/man1/* "/usr/share/man/man1/" -f
    cleanup
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    zoxide --version 2>/dev/null | awk '{print $2}' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/ajeetdsouza/zoxide/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/zoxide" || echo
}

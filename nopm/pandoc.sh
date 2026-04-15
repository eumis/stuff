#!/usr/bin/env bash

install() {
    local version="$1"

    rm -rf ./pandoc* || echo
    uninstall

    local os=$(get_os)
    local arch=$(get_architecture)
    case "$arch" in
        aarch64) arch="arm64" ;;
        x86_64) arch="amd64" ;;
    esac

    curl -LRs "https://github.com/jgm/pandoc/releases/download/${version}/pandoc-${version}-${os}-${arch}.tar.gz" -o pandoc.tar.gz
    tar xf pandoc.tar.gz
    sudo cp "./pandoc-${version}/bin/pandoc" /usr/local/bin/pandoc
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    pandoc --version 2>/dev/null | head -n 1 | awk '{print $2}' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/jgm/pandoc/releases/latest | jq -r '.tag_name'
}

uninstall() {
    sudo rm -f "/usr/local/bin/pandoc" || echo
}

#!/usr/bin/env bash

install() {
    local version="$1"

    rm -rf ./dysk* || echo
    uninstall
    curl -LRs "https://github.com/tree-sitter/tree-sitter/archive/refs/tags/v${version}.tar.gz" -o tree-sitter.tar.gz
    tar xf tree-sitter.tar.gz
    cd "tree-sitter-${version}"
    cargo build --release
    sudo cp -r ./target/release/tree-sitter /usr/local/bin/
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    tree-sitter --version 2>/dev/null | awk '{print $2}' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest | jq -r '.tag_name' | tr -d 'vb'
}

uninstall() {
    sudo rm -f "/usr/local/bin/tree-sitter" || echo
}

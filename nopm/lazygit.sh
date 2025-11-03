#!/usr/bin/env bash

install() {
    local version="$1"
    local os=$(get_os)
    local arch=$(get_architecture)

    rm -f ./lazygit || echo
    curl -LRs "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_${os}_${arch}.tar.gz" -o lazygit.tar.gz
    tar xf lazygit.tar.gz lazygit
    chmod u+x ./lazygit
    sudo mv lazygit "/usr/local/bin/lazygit" -f
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    lazygit --version 2>/dev/null | grep -oP 'version=\K[^,]+' | head -n1 | tr -d 'v' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/lazygit" || echo
}

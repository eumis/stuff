#!/usr/bin/env bash

get_file_name() {
    local version=$1
    arch=$(get_architecture)
    case "$arch" in
        aarch64) arch="arm64" ;;
        x86_64) arch="amd64" ;;
    esac
    os=$(get_os)
    echo "ctop-$version-$os-$arch"
}

install() {
    local version="$1"

    rm -f ctop || echo
    curl -LRs "https://github.com/bcicen/ctop/releases/download/v$version/$(get_file_name $version)" -o ctop
    chmod u+x ./ctop
    sudo mv ctop "/usr/local/bin/ctop" -f
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    ctop -v 2>/dev/null | awk '{print $3}' | tr -d ',' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/bcicen/ctop/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/ctop" || echo
}

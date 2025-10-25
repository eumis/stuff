#!/usr/bin/env bash

install() {
    local app_path="$1"
    local version=$(ensure_v_prefix $2)

    rm -f ctop || echo
    curl -LRs "https://github.com/bcicen/ctop/releases/download/$version/ctop-0.7.7-linux-amd64" -o ctop
    chmod u+x ./ctop
    ask_sudo mv ctop "$1" -f
}

update() {
    local app_path="$1"
    local version="$2"

    install $app_path $version
}

get_installed_version() {
    local app=$1

    $1 -v | awk '{print $3}' > /dev/null || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/bcicen/ctop/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    local app_path="$1"

    ask_sudo rm "$app_path" || echo
}

#!/usr/bin/env bash

get_file_name() {
    local version=$1
    arch=$(get_architecture)
    case "$arch" in
        aarch64) echo "ctop-$version-linux-arm64" ;;
        *) echo "ctop-$version-linux-amd64" ;;
    esac
}

install() {
    local app_path="$1"
    local version="$2"
    local vversion=$(ensure_v_prefix $2)

    rm -f ctop || echo
    curl -LRs "https://github.com/bcicen/ctop/releases/download/$vversion/$(get_file_name $version)" -o ctop
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

#!/usr/bin/env bash

get_file_name() {
    arch=$(get_architecture)
    [[ "$arch" == "aarch64" ]] && arch="arm64"
    echo "nvim-linux-$arch.appimage"
}

install() {
    local version="$1"
    local package_name="yazi-$(get_architecture)-unknown-linux-musl"

    sudo rm -f "/usr/local/bin/yazi" || echo
    sudo rm -f "/usr/local/bin/ya" || echo
    rm -rf "./$package_name" || echo
    curl -LRs "https://github.com/sxyazi/yazi/releases/download/v$version/$package_name.zip" -o yazi.zip
    unzip yazi.zip
    sudo mv "$package_name" "/opt/yazi" -f
    sudo ln -s /opt/yazi/ya /usr/local/bin/ya
    sudo ln -s /opt/yazi/yazi /usr/local/bin/yazi
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    yazi --version 2>/dev/null | awk '{print $2}' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/sxyazi/yazi/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm -f "/usr/local/bin/yazi" || echo
    sudo rm -f "/usr/local/bin/ya" || echo
    sudo rm -rf "/opt/yazi" || echo
}

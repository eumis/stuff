#!/usr/bin/env bash

install() {
    local version="$1"

    rm -rf ./tuxguitar* || echo
    uninstall
    curl -LRs "https://github.com/helge17/tuxguitar/releases/download/${version}/tuxguitar-${version}-linux-swt-amd64.tar.gz" -o tuxguitar.tar.gz
    tar xf tuxguitar.tar.gz
    sudo cp -r "tuxguitar-${version}-linux-swt-amd64" /opt/tuxguitar
    sudo ln -sf /opt/tuxguitar/tuxguitar.sh /usr/local/bin/tuxguitar
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    tuxguitar --version 2>/dev/null | awk '{print $3}' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/helge17/tuxguitar/releases/latest | jq -r '.tag_name' | tr -d 'vb'
}

uninstall() {
    sudo rm -f "/usr/local/bin/tuxguitar" || echo
    sudo rm -rf "/opt/tuxguitar" || echo
}

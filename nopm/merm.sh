#!/usr/bin/env bash

cleanup() {
    rm -rf mermaid-ascii || echo
    rm -f merg.tar.gz || echo
}

install() {
    local version="$1"
    local os=$(get_os)
    local arch=$(get_architecture)

    cleanup
    curl -LRs "https://github.com/AlexanderGrooff/mermaid-ascii/releases/download/$version/mermaid-ascii_Linux_$arch.tar.gz" -o merm.tar.gz
    tar -xf merm.tar.gz
    sudo cp mermaid-ascii "/usr/local/bin/merm" -f
    echo $version >> ./merm.version
    sudo mv ./merm.version /opt/merm.version
    cleanup
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    cat /opt/merm.version 2>/dev/null || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/AlexanderGrooff/mermaid-ascii/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/merm" || echo
}

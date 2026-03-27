#!/usr/bin/env bash

install() {
    local version="$1"
    uninstall
    rm go.tar.gz || echo
    rm -rf go || echo

    curl -LRs "https://go.dev/dl/go$version.linux-amd64.tar.gz" -o go.tar.gz
    tar -xzf go.tar.gz
    sudo mv go /opt/
    sudo ln -sf /opt/go/bin/go /usr/local/bin/go
    sudo ln -sf /opt/go/bin/gofmt /usr/local/bin/gofmt
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    go version 2>/dev/null | awk '{print $3}' | cut -c3- || echo
}

get_latest_version() {
    git ls-remote --tags https://github.com/golang/go.git | rg "refs/tags/go" | awk '{print $2}' | sed -e 's/refs\/tags\/go//g' | sort -V | tail -n 1
}

uninstall() {
    sudo rm "/usr/local/bin/go" || echo
    sudo rm "/usr/local/bin/gofmt" || echo
    sudo rm -rf "/opt/go" || echo
}

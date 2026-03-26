#!/usr/bin/env bash

install() {
    uninstall
    rm go.tar.gz || echo
    rm -rf go || echo

    local archive="go.tar.gz"
    local exe="usql_static"
    curl -LRs "https://go.dev/dl/go1.25.6.linux-amd64.tar.gz" -o go.tar.gz
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
    go version 2>/dev/null | awk '{print $2}' || echo
}

get_latest_version() {
    echo
}

uninstall() {
    sudo rm "/usr/local/bin/go" || echo
    sudo rm "/usr/local/bin/gofmt" || echo
    sudo rm -rf "/opt/go" || echo
}

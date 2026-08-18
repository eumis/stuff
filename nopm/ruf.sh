#!/usr/bin/env bash

fetch() {
    if [[ ! -d "./ruf_repo" ]]; then
        git clone em@homer:git/ruf ruf_repo
        cd ..
    else
        cd ./ruf_repo
        git fetch origin --tags
        cd ..
    fi
}

checkout() {
    local tag="$1"
    cd ./ruf_repo
    git checkout .
    git checkout tags/"$tag"
    cd ..
}

cleanup() {
    rm -rf target
}

install() {
    local version="$1"
    local os=$(get_os)

    fetch
    checkout "$version"
    cd ./ruf_repo
    cleanup

    cargo build --release

    if [[ "$os" == "linux" ]]; then
        sudo install target/release/ruf "/usr/local/bin/ruf"
    else
        echo "$version" >> "/c/tools/ruf/version.txt"
    fi

    cleanup
    cd ..
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    local os=$(get_os)
    if [[ "$os" == "linux" ]]; then
        ruf --version 2>/dev/null || echo
    else
        head -n 1 "/c/tools/ruf/version.txt" 2>/dev/null || echo
    fi
}

get_latest_version() {
    fetch
    cd ./ruf_repo
    git tag -l | sort -V | tail -n 1
    cd ..
}

uninstall() {
    local os=$(get_os)
    if [[ "$os" == "linux" ]]; then
        sudo rm "/usr/local/bin/ruf"
    else
        rm -rf "/c/tools/ruf"
    fi
}

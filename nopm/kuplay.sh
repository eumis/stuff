#!/usr/bin/env bash

fetch() {
    if [[ ! -d "./kuplay_repo" ]]; then
        git clone em@homer:git/kuplay kuplay_repo
        cd ..
    else
        cd ./kuplay_repo
        git fetch origin --tags
        cd ..
    fi
}

checkout() {
    local tag="$1"
    cd ./kuplay_repo
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
    cd ./kuplay_repo
    cleanup

    cd crates/kuplay-gui
    cargo build --release
    cd ../..

    if [[ "$os" == "linux" ]]; then
        sudo mv target/release/kuplay-gui "/usr/local/bin/kuplay" -f
        echo "[Desktop Entry]
Version=$version
Name=kuplay
GenericName=Media player
Exec=kuplay
TryExec=kuplay
Terminal=false
Type=Application
Categories=Audio;Player;
Keywords=Player;Audio;" | sudo tee "/usr/share/applications/kuplay.desktop" > /dev/null
    else
        echo "$version" >> "/c/tools/kuplay/version.txt"
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
        kuplay --version 2>/dev/null || echo
    else
        head -n 1 "/c/tools/kuplay/version.txt" 2>/dev/null || echo
    fi
}

get_latest_version() {
    fetch
    cd ./kuplay_repo
    git tag -l | sort -V | tail -n 1
    cd ..
}

uninstall() {
    local os=$(get_os)
    if [[ "$os" == "linux" ]]; then
        sudo rm "/usr/local/bin/kuplay"
    else
        rm -rf "/c/tools/kuplay"
    fi
}

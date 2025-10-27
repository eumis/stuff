#!/usr/bin/env bash

cleanup() {
    local archive="$1"
    local exe="$1"
    rm -f "./$archive" || echo
    rm -f ./usql_static || echo
}

get_file_name() {
    local version="$1"
    local os=$(get_os)
    local arch=$(get_architecture)
    arch=$(map_architecture "$arch")

    echo "usql_static-$version-$os-$arch"
}

install() {
    local app_path="$1"
    local version=$2
    local os=$(get_os)
    local filename=$(get_file_name $version)

    if [[ $os == "linux" ]]; then
        local archive="usql.tar.bz2"
        local exe="usql_static"
        cleanup $archive $exe
        curl -LRs "https://github.com/xo/usql/releases/download/v$version/$filename.tar.bz2" -o "$archive"
        tar -xf "./$archive"
        sudo mv "$exe" "$1" -f
        cleanup $archive $exe
    else
        local archive="usql.tar.bz2"
        local exe="usql_static"
        cleanup $archive $exe
        curl -LRs "https://github.com/xo/usql/releases/download/v$version/$filename.zip" -o "$archive"
        unzip "./$archive"
        mv usql.exe "$1" -f
        cleanup $archive $exe
    fi
}

update() {
    local app_path="$1"
    local version="$2"

    install $app_path $version
}

get_installed_version() {
    local app=$1

    $1 --version | rg version | awk '{print $3}' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/xo/usql/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    local app_path="$1"

    ask_sudo rm "$app_path"
}

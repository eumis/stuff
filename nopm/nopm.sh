#!/usr/bin/env bash

install() {
    local app_path="$1"

    safe_run rm ./nopm
    if [[ ! -d "./nopm_repo" ]]; then
        git clone em@homer:git/nopm nopm_repo
    else
        cd ./nopm_repo
        git pull origin main
        cd ..
    fi
    echo "$1"
    cp ./nopm_repo/src/nopm.sh ./nopm
    chmod u+x ./nopm
    ask_sudo mv nopm "$1" -f
}

update() {
    local app_path="$1"

    install $1
}

get_installed_version() {
    local app=$1

    $1 --version | grep -m2 '^nopm' | awk '{print $2}' | tr -d 'v'
}

get_latest_version() {
    echo "9.9.9"
}

uninstall() {
    local app_path="$1"

    ask_sudo rm "$app_path"
}

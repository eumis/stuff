#!/usr/bin/env bash

fetch() {
    if [[ ! -d "./nopm_repo" ]]; then
        git clone em@homer:git/nopm nopm_repo -q
    else
        cd ./nopm_repo
        git fetch origin --tags -q
        cd ..
    fi
}

checkout() {
    local tag="$1"
    cd ./nopm_repo
    git checkout tags/"$tag" -q
    cd ..
}

install() {
    local app_path="$1"
    local version=$(ensure_v_prefix $2)

    rm ./nopm -f || echo
    fetch
    checkout "$version"
    cp ./nopm_repo/src/nopm.sh ./nopm
    chmod u+x ./nopm
    ask_sudo mv nopm "$1" -f
}

update() {
    local app_path="$1"
    local version="$2"

    install $app_path $version
}

get_installed_version() {
    local app=$1

    $1 --version | grep -m2 '^nopm' | awk '{print $2}' | tr -d 'v' || echo
}

get_latest_version() {
    fetch
    cd ./nopm_repo
    git tag -l | sort -V | tail -n 1 | tr -d 'v'
    cd ..
}

uninstall() {
    local app_path="$1"

    ask_sudo rm "$app_path"
}

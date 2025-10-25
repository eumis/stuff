#!/usr/bin/env bash

fetch() {
    if [[ ! -d "./cuplay_repo" ]]; then
        git clone em@homer:git/cuplay cuplay_repo
        cd ./cuplay_repo
        python3.12 -m venv venv
        cd ..
    else
        cd ./cuplay_repo
        git fetch origin --tags
        cd ..
    fi
}

checkout() {
    local tag="$1"
    cd ./cuplay_repo
    git checkout tags/"$tag"
    cd ..
}

cleanup() {
    rm -rf run.build
    rm -rf run.dist
    rm -rf run.onefile-build
}

build() {
    cd ./cuplay_repo
    cleanup
    source venv/bin/activate

    pip install --upgrade --force-reinstall .[build]
    nuitka --onefile --follow-imports --include-data-dir=src/ui/resources=ui/resources src/run.py

    deactivate
    cleanup
    cd ..
}

install() {
    local app_path="$1"
    local version="$2"

    fetch
    checkout "$version"
    build
    ask_sudo mv ./cuplay_repo/run.bin "$1" -f
}

update() {
    local app_path="$1"
    local version="$2"

    install $app_path $version
}

get_installed_version() {
    local app=$1

    $1 --version || echo
}

get_latest_version() {
    fetch
    cd ./cuplay_repo
    git tag -l | sort -V | tail -n 1
    cd ..
}

uninstall() {
    local app_path="$1"

    ask_sudo rm "$app_path"
}

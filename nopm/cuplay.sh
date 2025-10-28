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
    local version="$1"

    fetch
    checkout "$version"
    build
    sudo mv ./cuplay_repo/run.bin "/usr/local/bin/cuplay" -f
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    cuplay --version 2>/dev/null || echo
}

get_latest_version() {
    fetch
    cd ./cuplay_repo
    git tag -l | sort -V | tail -n 1
    cd ..
}

uninstall() {
    sudo rm "/usr/local/bin/cuplay"
}

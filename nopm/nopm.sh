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
    local version="$1"

    rm ./nopm -f || echo
    fetch
    checkout "$version"
    cp ./nopm_repo/src/nopm.sh ./nopm
    chmod u+x ./nopm
    sudo mv nopm "/usr/local/bin/nopm" -f
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    nopm --version 2>/dev/null | grep -m2 '^nopm' | awk '{print $2}' | tr -d 'v' || echo
}

get_latest_version() {
    fetch
    cd ./nopm_repo
    git tag -l | sort -V | tail -n 1
    cd ..
}

uninstall() {
    sudo rm "/usr/local/bin/nopm" || echo
}

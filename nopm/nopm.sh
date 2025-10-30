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
    local os=$(get_os)

    rm ./nopm -f || echo
    fetch
    checkout "$version"
    cp ./nopm_repo/src/nopm.sh ./nopm
    chmod u+x ./nopm
    if [[ "$os" == "linux" ]]; then
        sudo mv nopm "/usr/local/bin/nopm" -f
    else
        mv nopm "/c/tools/nopm" -f
    fi
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
    local os=$(get_os)
    if [[ "$os" == "linux" ]]; then
        sudo rm "/usr/local/bin/nopm" || echo
    else
        rm -rf "/c/tools/nopm" || echo
    fi
}

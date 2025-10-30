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

install() {
    local version="$1"
    local os=$(get_os)

    fetch
    checkout "$version"
    cd ./cuplay_repo
    cleanup

    if [[ "$os" == "linux" ]]; then
        source venv/bin/activate
        pip install --upgrade --force-reinstall .[build]
        python -m nuitka --onefile --follow-imports --include-data-dir=src/ui/resources=ui/resources src/run.py
        sudo mv ./run.bin "/usr/local/bin/cuplay" -f
    else
        source venv/Scripts/activate
        pip install --upgrade --force-reinstall .[build]
        python -m nuitka --standalone --follow-imports --include-data-dir=src/ui/resources=ui/resources --include-package=multidict --include-package=aiohttp --windows-console-mode=disable src/run.py
        mv ./run.dist/run.exe ./run.dist/cuplay.exe
        rm -rf "/c/tools/cuplay"
        mv ./run.dist "/c/tools/cuplay" -f
        echo "$version" >> "/c/tools/cuplay/version.txt"
    fi

    deactivate
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
        cuplay --version 2>/dev/null || echo
    else
        head -n 1 "/c/tools/cuplay/version.txt" 2>/dev/null || echo
    fi
}

get_latest_version() {
    fetch
    cd ./cuplay_repo
    git tag -l | sort -V | tail -n 1
    cd ..
}

uninstall() {
    local os=$(get_os)
    if [[ "$os" == "linux" ]]; then
        sudo rm "/usr/local/bin/cuplay"
    else
        rm -rf "/c/tools/cuplay"
    fi
}

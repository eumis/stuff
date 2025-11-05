#!/usr/bin/env bash

install() {
    local version="$1"

    rm -f ./kitty.txz || echo
    rm -rf ./kitty.app || echo
    echo "https://github.com/kovidgoyal/kitty/releases/download/v$version/kitty-$version-x86_64.txz"
    curl -LRs "https://github.com/kovidgoyal/kitty/releases/download/v$version/kitty-$version-x86_64.txz" -o kitty.txz
    mkdir kitty.app
    tar -C kitty.app -xJof kitty.txz
    cp -f kitty.app/share/applications/kitty.desktop "$HOME/.local/share/applications/"
    cp -f kitty.app/share/applications/kitty-open.desktop "$HOME/.local/share/applications/"
    sed -i "s|Icon=kitty|Icon=/opt/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sudo mv kitty.app /opt/
    sudo ln -s /opt/kitty.app/bin/kitty /usr/local/bin/kitty
    ln -s "$HOME/stuff/kitty" "$HOME/.config" || echo
    rm -f ./kitty.txz || echo
    rm -rf ./kitty.app || echo
}

update() {
    local version="$1"

    install $version
}

get_installed_version() {
    kitty --version 2>/dev/null | awk '{print $2}' || echo
}

get_latest_version() {
    curl -s https://api.github.com/repos/kovidgoyal/kitty/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
    sudo rm "/usr/local/bin/kitty" || echo
    sudo rm -rf "/opt/kitty.app" || echo
}

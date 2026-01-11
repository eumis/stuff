#!/usr/bin/env bash

install() {
    local version="$1"

    rm -f ./kitty.txz || echo
    rm -rf ./kitty.app || echo
    echo "https://github.com/kovidgoyal/kitty/releases/download/v$version/kitty-$version-x86_64.txz"
    curl -LRs "https://github.com/kovidgoyal/kitty/releases/download/v$version/kitty-$version-x86_64.txz" -o kitty.txz
    mkdir kitty.app
    tar -C kitty.app -xJof kitty.txz
    sudo cp -f kitty.app/share/applications/kitty.desktop "/usr/share/applications/"
    sudo cp -f kitty.app/share/applications/kitty-open.desktop "/usr/share/applications/"
    sudo sed -i "s|Icon=kitty|Icon=/opt/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" /usr/share/applications/kitty*.desktop
    sudo rm -rf /opt/kitty.app
    sudo mv kitty.app /opt/
    sudo ln -sf /opt/kitty.app/bin/kitty /usr/local/bin/kitty
    ln -sf "$HOME/stuff/kitty" "$HOME/.config" || echo
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

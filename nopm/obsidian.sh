#!/usr/bin/env bash

install() {
	local version="$1"

	rm -f ./bosidian.appimage || echo
	curl -LRs "https://github.com/obsidianmd/obsidian-releases/releases/download/v$version/Obsidian-$version.AppImage" -o obsidian.appimage
	sudo install -m 755 obsidian.appimage "/usr/local/bin/obsidian"

	echo "[Desktop Entry]
Version=$version
Name=obsidian
GenericName=Note taking
Exec=obsidian
TryExec=obsidian
Terminal=false
Type=Application
Categories=Utility;
Keywords=Notes;" | sudo tee "/usr/share/applications/obsidian.desktop" >/dev/null
}

update() {
	local version="$1"

	install $version
}

get_installed_version() {
	obsidian --version 2>/dev/null | grep -m2 '^NVIM' | awk '{print $2}' | tr -d 'v' || echo
}

get_latest_version() {
	curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | jq -r '.tag_name' | tr -d 'v'
}

uninstall() {
	sudo rm "/usr/local/bin/obsidian" || echo
}

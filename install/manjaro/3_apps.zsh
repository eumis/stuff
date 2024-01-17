# enabling snap
sudo pacman -S snapd --noconfirm
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap


sudo pacman -S brave-browser --noconfirm
sudo pacman -S steam --noconfirm
sudo pacman -S wine --noconfirm
sudp pacman -S keepass --noconfirm
sudp pacman -S discord --noconfirm

flatpak install flathub org.telegram.desktop
flatpak install flathub ar.com.tuxguitar.TuxGuitar

snap install spotify

# gamepad
mkdir temp
cd temp
git clone https://github.com/medusalix/xone
cd xone
sudo ./install.sh --release
sudo xone-get-firmware.sh --skip-disclaimer

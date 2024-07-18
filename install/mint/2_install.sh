cd ~

# git
sudo apt install git -y

# configs
git clone git@github.com:eumis/stuff.git

# fish
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update -y
sudo apt install fish -y
chsh -s $(which fish)
echo 'eval (ssh-agent -c)' >> ~/.config/fish/config.fish

# bat
sudo apt install bat -y
echo 'alias bat=batcat' >> ~/.bashrc
echo 'alias bat=batcat' >> ~/.config/fish/config.fish

mkdir temp
cd temp

# nerd font
mkdir ~/.local/share/fonts
curl -fLo CodeNewRoman.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CodeNewRoman.tar.xz
tar -xf CodeNewRoman.tar.xz -C ~/.local/share/fonts/

# kitty
ln -s ~/stuff/kitty ~/.config
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
echo 'alias kitty=~/.local/kitty.app/bin/kitty' >> ~/.zshrc
echo 'alias kitty=~/.local/kitty.app/bin/kitty' >> ~/.config/fish/config.fish
mkdir ~/.local/share/applications
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# onetool
ln -s ~/stuff/onetool ~/.config

# wx dependencies
sudo apt install libsdl2-2.0-0 -y
sudo apt install python3-wxgtk4.0 -y
sudo apt install python3-wxgtk-webview4.0 -y

# python
sudo apt install python3.11 -y
sudo apt install python3.11-full
sudo apt install python3-pip
echo 'alias python=python3.11' >> ~/.bashrc
echo 'alias python=python3.11' >> ~/.config/fish/config.fish
echo 'alias pip=python3.11 -m pip' >> ~/.bashrc
echo 'alias pip=python3.11 -m pip' >> ~/.config/fish/config.fish

# docker
sudo apt install docker -y

# neovim
ln -s ~/stuff/nvim ~/.config

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

sudo apt install build-essential -y
sudo apt install gcc -y
sudo apt install lua5.4 -y
sudo apt install unzip -y
sudo apt install ripgrep -y
sudo apt install fd-find -y
sudo apt install xsel -y

echo 'alias fd=fdfind' >> ~/.bashrc
echo 'alias fd=fdfind' >> ~/.config/fish/config.fish

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
mv nvim.appimage ~/.local
chmod u+x ~/.local/nvim.appimage
echo 'alias nvim=~/.local/nvim.appimage' >> ~/.bashrc
echo 'alias nvim=~/.local/nvim.appimage' >> ~/.config/fish/config.fish
git config --global core.editor ~/.local/nvim.appimage

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
~/.local/nvim.appimage -c 'PlugInstall' -c 'TSUpdateSync' -c 'qall'

# brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install brave-browser -y

# wine
sudo dpkg --add-architecture i386 
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
sudo apt update -y
sudo apt install --install-recommends winehq-stable -y

# proton
curl -LO  https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb
sudo apt update -y
sudo apt install proton-vpn-gnome-desktop

# drawio
flatpak install flathub com.jgraph.drawio.desktop -y

# keepass
sudo add-apt-repository ppa:ubuntuhandbook1/keepass2
sudo apt update
sudo apt install keepass2 -y

# discord
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt install ./discord.deb -y

# telegram
curl -o telegram.tar.xz https://td.telegram.org/tlinux/tsetup.4.14.6.tar.xz
tar -xvf telegram.tar.xz
mv Telegram ~/.local/telegram.app
chmod u+x ~/.local/telegram.app/Telegram

# tuxguitar
flatpak install flathub ar.com.tuxguitar.TuxGuitar -y

# audacity
curl -o audacity.appimage https://github.com/audacity/audacity/releases/download/Audacity-3.4.2/audacity-linux-3.4.2-x64.AppImage
mv audacity.appimage ~/.local/audacity.appimage
chmod u+x ~/.local/audacity.appimage
cat >~/.local/share/applications/audacity.desktop <<EOL
[Desktop Entry]
Type=Application
Name=Audacity
TryExec=~/.local/audacity.appimage
Exec=~/.local/audacity.appimage
Terminal=false
EOL

# spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update -y
sudo apt install spotify-client -y

# vlc
sudo apt install vlc

# steam
wget https://repo.steampowered.com/steam/archive/precise/steam_latest.deb
sudo apt install ./steam_latest.deb -y

# gamepad
git clone https://github.com/medusalix/xone
cd xone
sudo ./install.sh --release
sudo xone-get-firmware.sh --skip-disclaimer
cd ..

# keyboard
sudo apt install libusb-1.0-0-dev
sudo cp ~/stuff/install/50-zsa.rules /etc/udev/rules.d/
sudo groupadd plugdev
sudo usermod -aG plugdev $USER

sudo apt update -y
cd ..
rm -rf temp

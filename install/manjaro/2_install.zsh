mkdir temp
cd temp

# tools
sudo pacman -S git --noconfirm
sudo pacman -S bat --noconfirm

# configs
git clone git@github.com:eumis/stuff.git

# fish
sudo pacman -S fish --noconfirm
chsh -s $(which fish)
echo 'eval (ssh-agent -c)' >> ~/.config/fish/config.fish

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

# docker
sudo pacman -S docker --noconfirm

# onetool
ln -s ~/stuff/onetool ~/.config

# neovim
ln -s ~/stuff/nvim ~/.config

sudo pacman -S lua --noconfirm
sudo pacman -S gcc --noconfirm
sudo pacman -S unzip --noconfirm
sudo pacman -S ripgrep --noconfirm
sudo pacman -S fd --noconfirm
sudo pacman -S npm --noconfirm
sudo pacman -S xsel --noconfirm
sudo pacman -S neovim --noconfirm
git config --global core.editor ~/.local/nvim.appimage

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c 'PlugInstall' -c 'TSUpdateSync' -c 'qall'

# python 3.10
# sudo pacman -Syy --noconfirm
# sudo pacman -S base-devel --noconfirm
# sudo pacman -S yay --noconfirm
# yay -S python310
sudo pacman -S python-pip --noconfirm
sudo pacman -S python-devtools --noconfirm
sudo pacman -S python-wxpython --noconfirm

# .net
sudo pacman -S dotnet-runtime --noconfirm
sudo pacman -S dotnet-sdk --noconfirm

# diagrams
flatpak install flathub com.jgraph.drawio.desktop -y

# brave
sudo pacman -S brave-browser --noconfirm

# wine
# sudo pacman -S wine --noconfirm

# keepass
sudo pacman -S keepass --noconfirm

# discord
sudo pacman -S discord --noconfirm

# telegram
flatpak install flathub org.telegram.desktop -y

# tuxguitar
flatpak install flathub ar.com.tuxguitar.TuxGuitar -y

# spotify
flatpak install flathub com.spotify.Client -y

# audacity
sudo pacman -S audacity --noconfirm

# proton vpn
pamac update --force-refresh
pamac build protonvpn-cli

# steam
sudo pacman -S steam --noconfirm

# gamepad
sudo pacman -S linux66-headers
sudo pacman -S dkms --noconfirm
sudo pacman -S cabextract --noconfirm
git clone https://github.com/medusalix/xone
cd xone
sudo ./install.sh --release
sudo xone-get-firmware.sh --skip-disclaimer

cd ~
rm -rf temp

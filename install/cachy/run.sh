temp_dir="$HOME/setup_tmp"
if [[ ! -d "$temp_dir" ]]; then
  mkdir -p "$temp_dir"
fi
cd "$temp_dir"

sudo pacman -Syu

# config
ln -s ~/stuff/nopm ~/.config
ln -s ~/stuff/fastfetch ~/.config
ln -sf ~/stuff/nvim ~/.config
echo 'eval (ssh-agent -c)' >> ~/.config/fish/config.fish

# nopm
git clone em@homer:git/nopm
cd nopm/src
bash nopm.sh install nopm

# fonts
nopm install nerdfonts

# terminal
nopm install kitty
sudo pacman -S kitty-terminfo --noconfirm

sudo pacman -S zoxide --noconfirm
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
echo "zoxide init fish | source" >> ~/.config/fish/config.fish

sudo pacman -S yazi --noconfirm

# dev tools
sudo pacman -S lazygit --noconfirm
sudo pacman -S wl-clipboard --noconfirm
sudo pacman -S docker docker-compose --noconfirm

nopm install nvim

sudo pacman -S sqlitebrowser --noconfirm
nopm install usql

# apps
nopm install cuplay
nopm install telegram
# nopm install discord
nopm install yt-dlp
nopm install vial

sudo pacman -S brave-bin --noconfirm
# sudo pacman -S chromium --noconfirm
sudo pacman -S cava --noconfirm
sudo pacman -S keepassxc --noconfirm
sudo pacman -S spotify-launcher --noconfirm
sudo pacman -S proton-vpn-gtk-app --noconfirm
sudo pacman -S libreoffice-still --noconfirm
sudo pacman -S wlsunset --noconfirm

# https://rust-lang.org/tools/install/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
nopm install go

# gaming
sudo pacman -S cachyos-gaming-meta --noconfirm
sudo pacman -S steam --noconfirm

# virtualbox
sudo pacman -S virtualbox-host-dkms --noconfirm
sudo pacman -S virtualbox --noconfirm
sudo pacman -S virtualbox-guest-utils --noconfirm
sudo pacman -S virtualbox-guest-iso --noconfirm
# sudo pacman -S virtualbox-host-modules-arch --noconfirm

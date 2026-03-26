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

sudo pacman -S zoxide
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
echo "zoxide init fish | source" >> ~/.config/fish/config.fish

sudo pacman -S yazi

# dev tools
sudo pacman -S lazygit
sudo pacman -S wl-clipboard
sudo pacman -S docker docker-compose

nopm install nvim

sudo pacman -S sqlitebrowser
nopm install usql

# apps
sudo pacman -S brave-bin
sudo pacman -S cava
nopm install cuplay
nopm install telegram
nopm install discord
nopm install yt-dlp

sudo pacman -S keepassxc

# https://rust-lang.org/tools/install/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# gaming
sudo pacman -S cachyos-gaming-meta
sudo pacman -S steam

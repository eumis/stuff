temp_dir="$HOME/setup_tmp"
if [[ ! -d "$temp_dir" ]]; then
  mkdir -p "$temp_dir"
fi
cd "$temp_dir"

sudo pacman -Syu

# fonts
nopm install nerdfonts

# config
ln -s ~/stuff/nopm ~/.config
ln -s ~/stuff/fastfetch ~/.config
echo 'eval (ssh-agent -c)' >> ~/.config/fish/config.fish

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

# apps
sudo pacman -S brave-bin
nopm install cuplay

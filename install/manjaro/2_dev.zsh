# tools
sudo pacman -S git --noconfirm
git clone git@github.com:eumis/stuff.git
sudo pacman -S bat --noconfirm


# fish
sudo pacman -S fish --noconfirm
chsh -s $(which fish)
echo 'eval (ssh-agent -c)' >> ~/.config/fish/config.fish

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

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c 'PlugInstall' -c 'TSUpdate' -c 'qall'

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

# python 3.9
sudo pacman -Syy --noconfirm
sudo pacman -S base-devel --noconfirm
sudo pacman -S yay --noconfirm
yay -S python39

# .net
sudo pacman -S dotnet-runtime --noconfirm
sudo pacman -S dotnet-sdk --noconfirm

# docker
sudo pacman -S docker --noconfirm

# diagrams
flatpak install flathub com.jgraph.drawio.desktop

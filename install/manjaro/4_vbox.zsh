# virtualbox
# https://linuxiac.com/how-to-install-virtualbox-on-manjaro-linux/
sudo pacman -S linux65-virtualbox-host-modules --noconfirm
sudo pacman -S virtualbox --noconfirm

# get version
vboxmanage -v | cut -dr -f1
# replace version in the next command
# wget https://download.virtualbox.org/virtualbox/7.0.12/Oracle_VM_VirtualBox_Extension_Pack-7.0.12.vbox-extpack
# sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.12.vbox-extpack
# sudo usermod -aG vboxusers $USER

sudo pacman -S virtualbox-guest-utils --no-confirm
sudo pacman -S virtualbox-guest-iso --no-confirm

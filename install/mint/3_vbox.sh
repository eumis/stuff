# dependencies
sudo apt install dkms build-essential linux-headers-$(uname -r) -y
sudo apt install apt-transport-https gnupg2


# install
curl -o virtualbox.deb 'https://download.virtualbox.org/virtualbox/7.0.14/virtualbox-7.0_7.0.14-161095~Ubuntu~jammy_amd64.deb'
sudo apt install ./virtualbox.deb -y
sudo apt update

# add user to vboxusers group
sudo usermod -a -G vboxusers $USER

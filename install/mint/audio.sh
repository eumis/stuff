
# pulse audio
# sudo apt install pulseaudio
# sudo apt install pulseaudio-utils pavucontrol


# jack
sudo apt install jackd


# tonelib gfx
# install dependency https://github.com/PetrusNoleto/Error-in-install-cisco-packet-tracer-in-ubuntu-23.10-unmet-dependencies/releases/tag/CiscoPacketTracerFixUnmetDependenciesUbuntu23.10
sudo apt install ./libgl1-mesa-glx_23.0.4-0ubuntu1.22.04.1_amd64.deb
# https://tonelib.net/gfx-overview.html
sudo apt install ./ToneLib-GFX-amd64.deb


# kx studio
# setup repo https://kx.studio/Repositories
sudo apt install cadence
# add user to audio group
sudo usermod -a -G audio $USER


# low latency kernel
sudo apt install linux-lowlatency

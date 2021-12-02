#!/bin/bash

mkdir ~/code
cd ~/code

# basic packages
sudo apt install -y unzip playerctl feh rxvt-unicode stow fish vim rofi tmux xfce4-settings imwheel xdotool

# dev dependencies
sudo apt install -y nginx meld postgresql python3-venv pipenv rbenv gnupg2 cmake libpython3-dev libwebkit2gtk-4.0-dev \
  libxcb-xkb-dev libfontconfig1-dev libgles2-mesa-dev libfreetype6-dev libexpat-dev

sudo snap install go --classic

# docker dependencies
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent \
  software-properties-common

# polybar
sudo apt install -y polybar

# polybar dependencies
sudo apt install -y build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev \
  libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto \
  libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev 

# polybar dependencies 2
sudo apt install -y libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev \
  libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev

# dunst dependencies
sudo apt install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev \
  libpango1.0-dev libgtk-3-dev libxdg-basedir-dev

# rxvt-unicode-truecolor dependencies
sudo apt install -y libperl-dev cvs

# i3 dependencies
sudo apt install -y libanyevent-i3-perl

# podman
sudo apt install -y podman

# firewall
sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw enable

# docker install
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose

# dunst install
cd ~/code && git clone git@github.com:dunst-project/dunst.git
cd ~/code/dunst
make
sudo make install

# light install
cd ~/code && git clone https://github.com/haikarainen/light.git
cd ~/code/light
./autogen.sh
./configure && make
sudo make install

# nvm
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

# mailhog
go get github.com/mailhog/MailHog
sudo sh -c 'echo "[Unit]
Description=MailHog service

[Service]
ExecStart=/usr/local/bin/mailhog \
  -api-bind-addr 127.0.0.1:8025 \
  -ui-bind-addr 127.0.0.1:8025 \
  -smtp-bind-addr 127.0.0.1:1025

[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/mailhog.service'
sudo ln -s $HOME/go/bin/MailHog /usr/local/bin/mailhog
sudo systemctl daemon-reload
sudo systemctl enable mailhog
sudo systemctl start mailhog

# stow dotfiles
cd ~/dotfiles
stow vim git dunst i3 pulse tmux xmodmap xresources alacritty

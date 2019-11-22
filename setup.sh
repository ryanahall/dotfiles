#!/bin/bash

mkdir ~/code
cd ~/code

# basic packages
sudo apt install -y unzip playerctl feh compton rxvt-unicode stow vim rofi tmux zsh xfce4-settings imwheel

# dev dependencies
sudo apt install -y nginx meld postgresql python3-venv cmake libpython3-dev libwebkit2gtk-4.0-dev \
  libxcb-xkb-dev libfontconfig1-dev libgles2-mesa-dev libfreetype6-dev libexpat-dev

sudo snap install go --classic

# docker dependencies
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent \
  software-properties-common

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

# fonts
cd ~/code && git clone git@github.com:ryanoasis/nerd-fonts.git
cd ~/code/nerd-fonts
./install.sh

# urxvt-unicode with 24 bit color patch
cd ~/code && cvs -z3 -d :pserver:anonymous@cvs.schmorp.de/schmorpforge co rxvt-unicode
cd ~/code/rxvt-unicode
./autogen.sh
./configure --enable-everything
sudo make install

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

# terraform install
terraform_version=0.12.13
wget https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip
unzip terraform_${terraform_version}_linux_amd64.zip
sudo mv terraform /usr/local/bin
rm terraform_${terraform_version}_linux_amd64.zip


# zsh
#sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# polybar install
cd ~/code && git clone git@github.com:polybar/polybar.git
cd ~/code/polybar
git submodule update --init --recursive

mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

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

# rvm
curl -sSL https://get.rvm.io | bash -s stable

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

# google-cloud-sdk
# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Update the package list and install the Cloud SDK
sudo apt update && sudo apt install -y google-cloud-sdk


# stow dotfiles
cd ~/dotfiles
stow vim git dunst i3 pulse tmux vim xmodmap xresources zsh

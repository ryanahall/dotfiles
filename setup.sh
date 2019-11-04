#!/bin/bash

cd ~
mkdir code
cd code

sudo apt install -y playerctl feh compton rxvt-unicode postgresql nginx stow vim rofi python-venv libpython-dev tmux

# fonts
git clone git@github.com:ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
cd ..

# urxvt-unicode with 24 bit color patch
sudo apt install -y libperl-dev
git clone git@github.com:exg/rxvt-unicode.git
cd rxvt-unicode
git checkout rxvt-unicode-rel-9.22
git clone git@github.com:enki/libev.git
git clone git@github.com:yusiwen/libptytty.git
git apply $HOME/dotfiles/urxvt-24-bit-color.patch
./autogen.sh
./configure --enable-everything --enable-24-bit-color
sudo make install
cd ..

# zsh
sudo apt install -y zsh
#sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# polybar dependencies
sudo apt install -y build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev 
# polybar dependencies 2
sudo apt install -y libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev

# polybar install
git clone git@github.com:polybar/polybar.git
cd polybar
git submodule update --init --recursive

mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

cd ~/code

# dunst dependencies
sudo apt install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev

# dunst install
git clone git@github.com:dunst-project/dunst.git
cd dunst
make
sudo make install

# light install
git clone https://github.com/haikarainen/light.git
cd light
./autogen.sh
./configure && make
sudo make install
cd ..


# nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash


# stow dotfiles
cd ~/dotfiles
stow vim git dunst i3 pulse tmux vim xmodmap xresources zsh



#!/bin/bash

# nerd-fonts
cd ~/code && git clone --depth 1 git@github.com:ryanoasis/nerd-fonts.git
cd ~/code/nerd-fonts
./install.sh

# powerline fonts
cd ~/code && git clone --depth 1 git@github.com:powerlne/fonts.git
cd ~/code/fonts
./install.sh

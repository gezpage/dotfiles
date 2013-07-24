#!/bin/bash

function output {
    echo -e "\e[01;33m${*}\e[00m"
}

output Installing Tmux and Tmuxinator for Debian based linux distro
output Press enter to continue
read

output Using APT to install dependencies
sudo apt-get install tmux rubygems cmake

output Now installing Tmuxinator ruby gem
sudo gem install tmuxinator

output Installing tmux-mem-cpu-load
cd ~/.dotfiles/.tmux-config
git submodule init
git submodule update
cd vendor/tmux-mem-cpu-load

output Now compiling
cmake .
make

output Installing to /usr/local/bin/tmux-mem-cpu-load
output If no errors above press enter to continue
read
sudo make install

output Done!

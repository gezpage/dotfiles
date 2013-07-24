#!/bin/bash

function output {
    echo -e "\e[01;33m${*}\e[00m"
}

output Installing Tmux and Tmuxinator for Debian based linux distro
output Press enter to continue
read

output Using APT to install dependencies
sudo apt-get install tmux rubygems

output Now installing Tmuxinator ruby gem
sudo gem install tmuxinator

output Done!

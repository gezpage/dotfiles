#!/bin/bash

function output {
    echo -e "\e[01;33m${*}\e[00m"
}

output Installing Powerline for Debian based linux distro
output Press enter to continue
read

output Using APT to install dependencies
sudo apt-get install python-pip

output Now installing powerline from github repo
pip install --user git+git://github.com/Lokaltog/powerline

output Done!

#!/bin/bash

function output {
    echo -e "\e[01;33m${*}\e[00m"
}

output Compiling YouCompleteMe Vim plugin
output Press enter to continue
read

cd ~/.vim/bundle/YouCompleteMe
./install.sh

output Done!


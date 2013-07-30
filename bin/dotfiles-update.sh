#!/bin/bash

# Does a git pull and submodule update on dotfiles repository

dotfiles_path=~/.dotfiles

function output {
    echo -e "\e[01;33m${*}\e[00m"
}

cd $dotfiles_path

output "* Pulling latest changes to the dotfiles"
git pull

output "* Initialising dotfiles submodules"
git submodule init

output "* Updating submodules"
git pull --recurse-submodules
git submodule update --recursive

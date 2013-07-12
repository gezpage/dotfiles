#!/bin/bash

# Does a git pull and submodule update on dotfiles repository

dotfiles_path=~/.dotfiles

function output {
    message=$*
    echo -e "\e[01;33m${message}\e[00m"
}

cd $dotfiles_path

# Freshen files
output "* Doing a git pull on the dotfiles repo"
git pull
git submodule init
git submodule update --recursive

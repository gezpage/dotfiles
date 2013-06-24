#!/bin/bash

# Install Gez's Vim config

vim_config=~/.vim
backup_vim_config=~/.vim~
dotfiles_script=~/Dev/git/dotfiles/bin/install-dotfiles.sh

function output {
    message=$*
    echo -e "\e[01;33m${message}\e[00m"
}

echo
echo "Gez's Vim config"
echo "This will delete an existing Vim config"
echo ""
echo -e "\e[01;33mBreak now if you do not wish to proceed\e[00m"
read

# Backup existing config
if [ -d $vim_config ]; then
    output "* .vim exists"
    if [ -d $vim_config ] || [ -f $vim_config ]; then
        output "* deleting existing backup"
        rm -rf $backup_vim_config
    fi
    output "* moving to .vim~"
    mv $vim_config $backup_vim_config
fi

if [ -d $vim_config ]; then
    output "There was an error backing up existing config - exiting"
    exit
fi

output "* Creating vim config dirs"
mkdir -p ${vim_config}/{_backup,_temp,_bundle}

output "* Cloning the vundle project for plugin management"
git clone https://github.com/gmarik/vundle.git ${vim_config}/bundle/vundle

output "* Cloning the colour schemes repo to avoid error on first start"
git clone https://github.com/flazz/vim-colorschemes ${vim_config}/bundle/vim-colorschemes

output "* Running dotfiles install script"
$dotfiles_script

output "* Creating temporary dir"
mkdir -p ~/tmp/vim

output "* Installing bundles"
vim +BundleInstall +qall

output "* Vim config install complete!"

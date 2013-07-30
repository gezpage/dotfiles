#!/bin/bash

# Install Gez's dotfiles

# Backup files have a tilde appended to the source filename
# If a backup file already exists it will be replaced
# Checks if target files are symlinks and just deletes them first

source=~/.dotfiles/
dotfiles_file=${source}dotfiles
dotfiles_custom=${source}dotfiles.local
required_dirs='bin .config/fish .vim'

if [ -f ${dotfiles_custom} ]; then
    dotfiles_file=$dotfiles_custom
fi

target=~/

function notice {
    echo -e "\e[01;33m${*}\e[00m"
}

function success {
    echo -e "\e[0;32m${*}\e[00m"
}

notice "* Checking required directories already exist"
mkdir -p ${required_dirs}

cd $source

notice "* Processing dotfiles"
# Create symlinks of dotfiles
for file in `grep -v \# ${dotfiles_file}`
do

    source_file=$source$file
    target_file=$target$file
    backup_file=$target$file~

    if [ -f $target_file ] || [ -d $target_file ]; then

        # File already exists - deal with it!
        if test -h "$target_file";
        then
            # Just delete the  symlink
            rm $target_file
        else
            if [ -f $backup_file ]; then
                # Delete existing backup file
                rm -rf $backup_file
            fi
            # Backup target file
            notice "* Backing up $target_file to $backup_file"
            mv $target_file $backup_file
        fi
    fi

    success "* Symlinking $source_file to $target_file"
    ln -sT $source_file $target_file

done

# Call post install script
${source}/bin/dotfiles-post-install.sh

echo
echo "Dotfiles installed!"
echo

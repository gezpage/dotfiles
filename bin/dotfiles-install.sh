#!/bin/bash

# Install Gez's dotfiles

# Backup files have a tilde appended to the source filename
# If a backup file already exists it will be replaced
# Checks if target files are symlinks and just deletes them first

source=~/.dotfiles/
dotfiles_file=${source}dotfiles
dotfiles_custom=${source}dotfiles.local

if [ -f ${dotfiles_custom} ]; then
    dotfiles_file=$dotfiles_custom
fi

target=~/

function output {
    message=$*
    echo -e "\e[01;33m${message}\e[00m"
}

cd $source

# Create symlinks of dotfiles
for file in `grep -v \# ${dotfiles_file}`
do

    source_file=$source$file
    target_file=$target$file
    backup_file=$target$file~

    output "* $file"

    if [ -f $target_file ] || [ -d $target_file ]; then

        # File already exists - deal with it!
        if test -h "$target_file";
        then
            #echo " - Deleting $target_file"
            # Just delete the  symlink
            rm $target_file
        else
            if [ -f $backup_file ]; then
                # Delete existing backup file
                rm -rf $backup_file
            fi
            # Backup target file
            echo " - Backing up $target_file to $backup_file"
            mv $target_file $backup_file
        fi
    fi

    echo " - Symlinking $source_file to $target_file"
    ln -sT $source_file $target_file

done

echo
echo "Dotfiles installed!"
echo

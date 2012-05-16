#!/bin/bash

SOURCE=~/Dev/git/dotfiles
BACKUP=~/.dotfiles.backup

if [ -d $BACKUP ]; then
        echo 'Backup folder exists, move or delete this and run again.'
else
        mkdir $BACKUP

        mv ~/.aliases $BACKUP/
        mv ~/.bashrc $BACKUP/
        mv ~/.bash_profile $BACKUP/
        mv ~/.gtkrc-2.0 $BACKUP/
        mv ~/.gtk-themes $BACKUP/
        mv ~/.vimrc.local $BACKUP/
        mv ~/.xinitrc $BACKUP/
        mv ~/.xmobarrc $BACKUP/
        mv ~/.Xmodmap $BACKUP/
        mv ~/.xmonad $BACKUP/
        mv ~/.Xresources $BACKUP/
        mv ~/.fonts.conf $BACKUP/
        mv ~/.fonts $BACKUP/

        ln -s $SOURCE/.aliases ~
        ln -s $SOURCE/.bashrc ~
        ln -s $SOURCE/.bash_profile ~
        ln -s $SOURCE/.gtkrc-2.0 ~
        ln -s $SOURCE/.gtk-themes ~
        ln -s $SOURCE/.vimrc.local ~
        ln -s $SOURCE/.xinitrc ~
        ln -s $SOURCE/.xmobarrc ~
        ln -s $SOURCE/.Xmodmap ~
        ln -s $SOURCE/.xmonad ~
        ln -s $SOURCE/.Xresources ~
        ln -s $SOURCE/.fonts.conf ~
        ln -s $SOURCE/.fonts ~

        echo 'Completed - you may have errors if files did not already exist!'
fi

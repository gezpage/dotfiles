#!/bin/bash

source=~/.dotfiles/

rm ~/.oh-my-zsh/themes/powerline.zsh-theme
ln -s ${source}modules/oh-my-zsh-powerline-theme/powerline.zsh-theme ~/.oh-my-zsh/themes/powerline.zsh-theme

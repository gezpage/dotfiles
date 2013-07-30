#!/bin/bash

source=~/.dotfiles/

rm ~/.oh-my-zsh/themes/powerline.zsh-theme >/dev/null 2>&1
ln -s ${source}modules/oh-my-zsh-powerline-theme/powerline.zsh-theme ~/.oh-my-zsh/themes/powerline.zsh-theme

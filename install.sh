#!/bin/bash

# Update script will pull down latest changes, if the install script
# has modifications, these will then affect the install

dotfiles_path=~/.dotfiles

${dotfiles_path}/bin/dotfiles-update.sh
${dotfiles_path}/bin/dotfiles-install.sh

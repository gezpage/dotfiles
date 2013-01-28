gezpage/dotfiles
================

My personal selection of "dotfiles".

Note
----
Remove / rename existing config files before symlinking

Bash
----
Custom bash profile including colour prompts and aliases

    ln -s ~/Dev/git/dotfiles/.bashrc ~/.bashrc
    ln -s ~/Dev/git/dotfiles/.bash_profile ~/.bash_profile
    ln -s ~/Dev/git/dotfiles/.aliases ~/.aliases

Vim
---
Get up and running in no time:

Create folders

    mkdir -p .vim/{_backup,_temp,_bundle}

Install Vundle (https://github.com/gmarik/vundle)

    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

Symlink vim config to your home dir

    ln -s ~/Dev/git/dotfiles/.vimrc ~/.vimrc
    ln -s ~/Dev/git/dotfiles/.vimrc.bundles ~/.vimrc.bundles

Use vundle to install bundles

    vim +BundleInstall +qall

Now run vim!

    vim

Git
---
Enabling custom hooks and config:

    ln -s ~/Dev/git/dotfiles/.git ~/.git
    ln -s ~/Dev/git/dotfiles/.git_template ~/.git_template
    ln -s ~/Dev/git/dotfiles/.gitconfig ~/.gitconfig

Ctags
-----

    ln -s ~/Dev/git/dotfiles/.ctags ~/.ctags

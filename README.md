# gezpage/dotfiles

Personal linux dotfiles.
Helper scripts assume you have cloned the repo to ~/Dev/git/dotfiles

## Dotfiles

### Installation

Create a ~/Dev/git directory

``` mkdir -p ~/Dev/git && cd ~/Dev/git ```

Clone the repository

``` git clone git@github.com:gezpage/dotfiles.git ```

If you want to hand pick which dotfiles will be installed, copy the
dotfiles file to dotfiles.local and make changes to it (delete lines as
needed).

``` cp ~/Dev/git/dotfiles{,.local} ```
``` vim ~/Dev/git/dotfiles.local ```

Now run the install script

``` ~/Dev/git/dotfiles/bin/install-dotfiles.sh ```

### Dotfiles Command
The install script will make a new command `dotfiles` available in your
path (assuming you have started a new fish or bash shell). Various
commands are available, to get help:

```dotfiles help```

### Updating dotfiles
Run ``` dotfiles update ``` to pull changes from github and relink to
your home directory.

### Installing the Vim config
Your existing vim config will be wiped and the vim config script also
updates your dotfiles.

If you wish to configure which Vim bundles are installed, copy the
.vimrc.bundles file to .vimrc.bundles.local in your home directory and
make changes to it:

``` cp ~/Dev/git/.vimrc.bundles ~/.vimrc.bundles.local ```
``` vim ~/.vimrc.bundles.local ```

Now run the vim config installer:

``` dotfiles vim-install ```

If you wish to use a local vimrc, create the file ~/.vimrc.local and it
will be called at the end of .vimrc

### Full Vim bundles update
```dotfiles vim-update```

### Vim bundles quick update (only removes and installs new as per
bundles config changes)
```dotfiles vim-update-quick```

### Bash / Fish shells
I have included config files for both Bash and Fish shell, if you want
to change to one, use the ```chsh``` command and then fully log out and
back in again.

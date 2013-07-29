# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="tjkirch"
#ZSH_THEME="lambda"
#ZSH_THEME="crunch"
#ZSH_THEME="bira"
#ZSH_THEME="robbyrussell"

DEFAULT_USER=gez

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git capistrano colored-man composer copydir copyfile debian git-flow github node npm screen svn symfony2 vagrant vundle vi-mode)

source $ZSH/oh-my-zsh.sh

# Create ~/bin if not exists
if [ ! -d  ~/bin ]; then
    mkdir ~/bin
fi

# Add user bin dir to start of path
export PATH=~/bin:$PATH

# Local bin
if [ -d  ~/.local/bin ]; then
    export PATH=$PATH:~/.local/bin
fi

# Heroku Toolbelt path
if [ -d  /usr/local/heroku/bin ]; then
    export PATH=$PATH:/usr/local/heroku/bin
fi

# Ruby gems path
if [ -d  ~/.gem/ruby/1.9.1/bin ]; then
    export PATH=$PATH:~/.gem/ruby/1.9.1/bin
fi

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator  ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# Aliases
source ~/.aliases

# Editor variable
export EDITOR="vim"

# Hi colour terminal support (Vim needs this)
#export TERM=xterm-256color
export TERM=screen-256color

# Funky MySQL prompt
export MYSQL_PS1="\u@\h [\d]> "

bindkey -e  ## emacs key bindings

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[^[[C' emacs-forward-word
bindkey '^[^[[D' emacs-backward-word

bindkey -s '^X^Z' '%-^M'
bindkey '^[e' expand-cmd-path
bindkey '^[^I' reverse-menu-complete
bindkey '^X^N' accept-and-infer-next-history
#bindkey '^W' kill-region
bindkey '^I' complete-word
# Fix weird sequence that rxvt produces
bindkey -s '^[[Z' '\t'

#if [[ -r ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh  ]]; then
    #source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
#fi

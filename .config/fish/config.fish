# Terminal 256 colour support (for Vim)
set TERM xterm-256color

# LS coloring
set -gx CLICOLOR 1
set -gx LSCOLORS ExFxCxDxBxegedabagacad

# Path
set -gx PATH /opt/local/bin /opt/local/sbin ~/bin $PATH

# Default editor
set -gx EDITOR vim
set -gx GIT_EDITOR vim

# Flashy MySQL prompt
set MYSQL_PS1 "\u@\h [\d]> "

# Aliases
. ~/.aliases

# Turn off greeting
set fish_greeting

# Hostname specific colours
switch (hostname)
    case akira
    set -g __fish_prompt_hostname_colour (set_color green)

    case revo
    set -g __fish_prompt_hostname_colour (set_color F3C)

    case magnesium
    set -g __fish_prompt_hostname_colour (set_color blue)

    case cadmium
    set -g __fish_prompt_hostname_colour (set_color FF3)

    # Default host colour
    case '*'
    set -g __fish_prompt_hostname_colour (set_color normal)
end

# Prompt config
function fish_prompt --description 'Write out the prompt'

    # Just calculate these once, to save a few cycles when displaying the prompt

    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color brown)
    end

    if not set -q __git_cb
        set __git_cb ":"(set_color F11)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color brown)""
    end

    switch $USER

        case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set -g __fish_prompt_cwd (set_color F3C)
            end
        end

        printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color F3C)
        end

        printf '%s%s@%s:%s%s%s%s$ ' $__fish_prompt_hostname_colour $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

        set_color normal

    end
end

# Show time on right of screen
function fish_right_prompt -d "Write out the right prompt"
    set_color green
    date "+%d-%b-%y %k:%M:%S"
end

# Launch byobu
[ -f /usr/bin/byobu-launcher -a -z "$BYOBU_WINDOWS"  ] ; and [ "$TERM" != "dumb"  ] ; and exec byobu-launcher

printf 'You are connected to %s%s ' $__fish_prompt_hostname_colour (hostname)

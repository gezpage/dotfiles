#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Fix keyboard mapping
setxkbmap -layout gb

# Make cursor normal
xsetroot -cursor_name left_ptr

# Load xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Load some programs
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
nm-applet &
google-chrome &
urxvt &
urxvt &
#thunar &

# Dropbox daemon
dropboxd &

# Wallpaper
#feh --bg-scale /home/gez/Dropbox/Images/wallpaper/1360x768/Deep__Abyss_Wallpaper_t0pho.jpg
feh --bg-scale /home/gez/Dropbox/Images/wallpaper/wallpaper-1648722.jpg
#feh --bg-scale /home/gez/Dropbox/Images/wallpaper/wallpaper-1304877.jpg

# Key bindings
xbindkeys

exec xmonad
# exec gnome-session
# exec awesome
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

#!/bin/bash 

cur_dir=`pwd`

__mklink(){
    ln -s $cur_dir/$1 $2 2>/dev/null
}

__mklink gtkrc-2.0 ~/.gtkrc-2.0
__mklink gtk.css  ~/.config/gtk-3.0/gtk.css
__mklink bashrc ~/.bashrc
__mklink profile ~/.profile
__mklink tmux.conf ~/.tmux.conf
__mklink eclimrc ~/.eclimrc
__mklink ctags ~/.ctags
__mklink terminator.conf ~/.config/terminator/config

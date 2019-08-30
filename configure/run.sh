#!/bin/bash 

cur_dir=`pwd`

__mklink(){
    if [[ $# == 3 ]]
    then
        if [[ x$3 == x"1" ]]
        then
            echo "rm -f $2"
            rm -f $2
        fi
    fi
    if [[ -f $2 ]]
    then
	    echo -n "$2 exist, delete(y/N): "
	    read input
	    if [[ x$input == xy || x$input == x ]]
	    then
		    echo "rm -f $2"
		    rm -f $2
	    fi
    fi
    dir=`dirname $2`
    mkdir -p $dir
    echo "ln -s $cur_dir/$1 $2"
    ln -s $cur_dir/$1 $2 2>/dev/null
}

# __mklink bashrc ~/.bashrc
__mklink profile ~/.profile
# __mklink fzf.bash ~/.fzf.bash 1
__mklink Rprofile ~/.Rprofile 
__mklink gtkrc-2.0 ~/.gtkrc-2.0
__mklink gtk.css  ~/.config/gtk-3.0/gtk.css
__mklink tmux.conf ~/.tmux.conf 1
__mklink eclimrc ~/.eclimrc 1
__mklink condarc ~/.condarc 1
__mklink ctags ~/.ctags 1
__mklink pip.conf ~/.config/pip/pip.conf
__mklink terminator.conf ~/.config/terminator/config 1
__mklink vim-with-servername ~/.local/share/nautilus/scripts/vim-with-servername 1
__mklink credentials ~/.plotly/.credentials 1
__mklink vim_binding.css $(jupyter --data-dir)/nbextensions/vim_binding/vim_binding.css
__mklink ssh.config ~/.ssh/config 1



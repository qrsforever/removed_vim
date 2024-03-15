#!/bin/bash 

cur_dir=`pwd`

__mklink(){
    if [[ $# == 3 ]]
    then
        if [[ x$3 == x"1" ]]
        then
            echo "rm -f $2"
            sudo rm -fr $2
        fi
    fi
    if [[ -f $2 ]]
    then
        if [[ ! -L $2 ]]
        then
            echo -n "$2 exist, delete(y/N): "
            read input
            if [[ x$input == xy || x$input == x ]]
            then
                echo "rm -f $2"
                sudo rm -f $2
            fi
        fi
    fi
    dir=`dirname $2`
    if [[ ! -d $dir ]]
    then
        mkdir -p $dir
    fi
    echo "ln -s $cur_dir/$1 $2"
    sudo ln -s $cur_dir/$1 $2 2>/dev/null
}

# __mklink Rprofile ~/.Rprofile 
# __mklink gtkrc-2.0 ~/.gtkrc-2.0
# __mklink gtk.css  ~/.config/gtk-3.0/gtk.css
# __mklink tmux.conf ~/.tmux.conf 1
# __mklink eclimrc ~/.eclimrc 1
# __mklink condarc ~/.condarc 1
__mklink ctags ~/.ctags 1
__mklink etc/pip.conf ~/.config/pip/pip.conf 1
# __mklink svn.conf ~/.subversion/servers 1
__mklink etc/npmrc   ~/.npmrc 1
if [[ ! -d /logs ]]
then
    sudo mkdir -p /logs
    sudo chown lidong:lidong /logs
    if [ ! -L ~/.local/share/applications/x-terminal-emulator.desktop ]
    then
        sudo ln -s /usr/share/applications/terminator.desktop ~/.local/share/applications/x-terminal-emulator.desktop
    fi
    __mklink terminator ~/.config/terminator 1
fi
__mklink etc/ssh.config ~/.ssh/config 1
__mklink nautilus/scripts ~/.local/share/nautilus/scripts 1

__mklink git/git.config ~/.gitconfig 1
__mklink etc/docker.daemon.json /etc/docker/daemon.json 1
__mklink etc/containerd.config.toml /etc/containerd/config.toml 1
__mklink apps/v2milk.desktop ~/.local/share/applications/v2milk.desktop 1
__mklink apps/gvim.desktop ~/.local/share/applications/gvim.desktop 1
__mklink goldendict ~/.goldendict 1

# __mklink credentials ~/.plotly/.credentials 1
# if [[ -d $(jupyter --data-dir) ]]
# then
#     __mklink vim_binding.css $(jupyter --data-dir)/nbextensions/vim_binding/vim_binding.css 1
# fi
# if [[ -d $(jupyter --config-dir) ]]
# then
#     __mklink notebook.json $(jupyter --config-dir)/nbconfig/notebook.json 1
# fi

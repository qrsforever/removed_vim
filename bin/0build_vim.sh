#!/bin/bash

source /etc/os-release
cur_fil=${BASH_SOURCE[0]}
vim_home=`dirname $(dirname $cur_fil)`
extern_dir=$vim_home/extern

if [[ x$1 == x ]]
then
    if [[ -d ${extern_dir}/vim ]]
    then
        vim_src_dir=${extern_dir}/vim
    else
        vim_src_dir=`pwd`
    fi
else
    vim_src_dir=$1
fi

echo "extern_dir = $extern_dir"

ENABLE_GUI=0
GUI_ARGS=

sudo apt install libncurses-dev
if [[ $ENABLE_GUI == 1 ]]
then
    sudo apt build-dep -y vim-gtk
    GUI_ARGS='--with-x'
else
    sudo apt build-dep -y vim
fi

cd $extern_dir

if [[ $VERSION_ID="22.04" ]]
then
    sudo apt install -y libluajit-5.1-dev liblua5.3-dev
else
    echo "need install liblua version"
    return
fi

cd $vim_src_dir

make distclean 2>/dev/null 

./configure \
    --prefix=/usr/local \
    --enable-pythoninterp=yes \
    --enable-python3interp=yes \
    --enable-luainterp=yes \
    --enable-multibyte \
    --enable-terminal \
    --enable-cscope \
    --with-features=huge \
    --enable-fontset \
    --enable-largefile \
    --with-compiledby="erlangai" $GUI_ARGS

sleep 3

make -j$(nproc); sudo make install

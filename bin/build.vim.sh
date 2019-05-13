#!/bin/bash

# Ubuntu 18.04

# 在源码目录下执行

sudo apt -y install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libluajit-5.1-dev libperl-dev


if [[ -e /usr/include/lua5.1/lua.h ]]
then
    sudo rm /usr/include/lauxlib.h /usr/include/luaconf.h /usr/include/lua.h
    sudo rm /usr/include/lua.hpp  /usr/include/lualib.h
    sudo ln -s /usr/include/lua5.1/lauxlib.h /usr/include/lauxlib.h
    sudo ln -s /usr/include/lua5.1/luaconf.h /usr/include/luaconf.h
    sudo ln -s /usr/include/lua5.1/lua.h     /usr/include/lua.h
    sudo ln -s /usr/include/lua5.1/lua.hpp   /usr/include/lua.hpp
    sudo ln -s /usr/include/lua5.1/lualib.h  /usr/include/lualib.h
fi

if [[ -e /usr/lib/x86_64-linux-gnu/liblua5.1.so ]]
then
    sudo rm /usr/lib/liblua.so
    sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.1.so.0.0.0  /usr/lib/liblua.so
fi

if [[ -e /usr/lib/x86_64-linux-gnu/libluajit-5.1.so.2.1.0 ]]
then
    sudo ln -s /usr/lib/x86_64-linux-gnu/libluajit-5.1.so.2.1.0 /usr/lib/x86_64-linux-gnu/libluajit.so
fi

sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
sudo rm -rf /usr/local/share/vim* /usr/bin/vim*

./configure \
    --enable-multibyte \
    --enable-perlinterp=dynamic \
    --enable-rubyinterp=dynamic \
    --with-ruby-command=/usr/bin/ruby \
    --enable-python3interp \
    --with-python3-config-dir=`python3-config --configdir` \
    --with-luajit \
    --enable-luainterp \
    --enable-cscope \
    --enable-gui=auto \
    --with-features=huge \
    --with-x \
    --enable-fontset \
    --enable-largefile \
    --disable-netbeans \
    --with-compiledby="qrsforever" \
    --enable-fail-if-missing

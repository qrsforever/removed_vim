#!/bin/bash

if [[ x$1 == x ]]
then
    vim_src_dir=`pwd`
else
    vim_src_dir=$1
fi

cur_fil=${BASH_SOURCE[0]}
vim_home=`dirname $(dirname $cur_fil)`
extern_dir=$vim_home/extern

echo "extern_dir = $extern_dir"

sudo apt-get build-dep vim

cd $extern_dir

if [[ ! -d $extern_dir/lua ]]
then
    git clone git@github.com:qrsforever/lua.git
fi

have_lua=`/usr/lib/liblua.so`

if [[ x$have_lua == x ]]
then
   sudo cp $extern_dir/lua/lib/liblua.so /usr/lib/
fi

cd $vim_src_dir

make distclean 2>/dev/null 

./configure \
    --prefix=/usr/local \
    --enable-multibyte \
    --enable-perlinterp=dynamic \
    --enable-rubyinterp=dynamic \
    --with-ruby-command=/usr/bin/ruby \
    --enable-python3interp \
    --enable-luainterp \
    --enable-cscope \
    --enable-gui=auto \
    --with-features=huge \
    --with-x \
    --enable-fontset \
    --enable-largefile \
    --disable-netbeans \
    --with-compiledby="qrsforever" \
    --enable-fail-if-missing \
    --with-python3-config-dir=`python3-config --configdir`\
    --with-lua-prefix=$extern_dir/lua \

sudo make install

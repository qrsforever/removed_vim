# install

## lua
   see extern/README.md

## build

    sudo apt-get build-dep vim

    ./configure \
    --enable-multibyte \
    --enable-perlinterp=dynamic \
    --enable-rubyinterp=dynamic \
    --with-ruby-command=/usr/bin/ruby \
    --enable-python3interp \
    --enable-luainterp \
    --with-luajit \
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
    --with-lua-prefix=/usr/local \

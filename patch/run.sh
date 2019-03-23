#!/bin/bash

VIM_HOME=`cd ../; pwd`

if [[ -d ../bundle/vim-pandoc/autoload/pandoc ]]
then
    cd $VIM_HOME/bundle/vim-pandoc/autoload/pandoc
    cp formatting.vim  formatting.vim.bak
    sed -i "s/formatoptions=tnroq/formatoptions=mMtnroq/g" `grep "formatoptions=tnroq" -l formatting.vim`
    cd -
fi

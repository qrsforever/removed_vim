" For load plugins

func! s:_AddPlugin(plgname) 
    let ss = split(a:plgname, '\/')
    let ballpath = expand('$HOME/.vim/bundle')
    if ss[0] ==# 'local'
        exec 'set rtp+=' . ballpath . '/' . ss[1]
    else
        Plugin a:plgname
    endif
    if len(ss) == 2
        let conf = ss[1]
    else
        let conf = ss[0]
    endif
    let inifile = ballpath . '/.configs/' . conf . '_conf.vim'
    if filereadable(inifile)
         exec 'source ' . inifile
    endif
endfunction
com! -nargs=*  -bar MyPlugin :call s:_AddPlugin(<args>)

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

MyPlugin 'VundleVim/Vundle.vim'
MyPlugin 'L9'
MyPlugin 'CCTree'
MyPlugin 'EasyMotion'
MyPlugin 'errormarker.vim'
MyPlugin 'grep.vim'
MyPlugin 'Valloric/YouCompleteMe'
MyPlugin 'Shougo/unite.vim'
MyPlugin 'Shougo/vimproc.vim'
MyPlugin 'Shougo/vimshell.vim'
MyPlugin 'SirVer/ultisnips'
MyPlugin 'scrooloose/syntastic'
MyPlugin 'scrooloose/nerdtree'
MyPlugin 'scrooloose/nerdcommenter'
MyPlugin 'majutsushi/tagbar'

MyPlugin 'local/vim-powerline'
MyPlugin 'local/fuzzyfinder'
MyPlugin 'local/vcscommand'
MyPlugin 'local/ydtrans'
MyPlugin 'local/maximizer'
MyPlugin 'local/lookupfile'
 
call vundle#end()

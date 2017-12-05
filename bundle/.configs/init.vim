" For load plugins

if !isdirectory(expand('~/.vim/bundle/Vundle.vim'))
    echomsg "-------------------------------------------------"
    echomsg "   Need install Vundle plugin, See README.md"
    echomsg "-------------------------------------------------"
    finish
endif

let allconfs = []

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
         call add(g:allconfs, inifile)
    endif
endfunction
com! -nargs=*  -bar MyPlugin :call s:_AddPlugin(<args>)

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

MyPlugin 'VundleVim/Vundle.vim'
MyPlugin 'L9'
" MyPlugin 'VimIM'
MyPlugin 'CCTree'
MyPlugin 'EasyMotion'
MyPlugin 'errormarker.vim'
MyPlugin 'grep.vim'
MyPlugin 'Lokaltog/vim-powerline'
if (filereadable('/usr/bin/clang'))
    " 等待YCM集成jedi, 参数补全
    " MyPlugin 'Valloric/YouCompleteMe'
endif
MyPlugin 'Shougo/unite.vim'
MyPlugin 'Shougo/vimproc.vim'
MyPlugin 'Shougo/vimshell.vim'
MyPlugin 'Shougo/neoyank.vim'
MyPlugin 'Shougo/neomru.vim'
" MyPlugin 'Shougo/unite-help'
" MyPlugin 'Shougo/unite-outline'
" MyPlugin 'Shougo/tabpagebuffer'
if (has('lua'))
    MyPlugin 'Shougo/neocomplete.vim'
else
    MyPlugin 'neocomplcache'
endif
" MyPlugin 'Shougo/neosnippet'
" MyPlugin 'Shougo/neosnippet-snippets'
" MyPlugin 'Shougo/neoinclude.vim'
" MyPlugin 'tsukkee/unite-tag'
" MyPlugin 'osyo-manga/unite-quickfix'
MyPlugin 'SirVer/ultisnips'
MyPlugin 'honza/vim-snippets'
MyPlugin 'scrooloose/syntastic'
MyPlugin 'scrooloose/nerdtree'
MyPlugin 'scrooloose/nerdcommenter'
MyPlugin 'majutsushi/tagbar'
MyPlugin 'jlanzarotta/bufexplorer'
MyPlugin 'DrawIt'
MyPlugin 'davidhalter/jedi-vim'
" MyPlugin 'zchee/deoplete-jedi'
MyPlugin 'skywind3000/asyncrun.vim'
" 对参数提示功能, 没有jedi做的完善
" MyPlugin 'tenfyzhong/CompleteParameter.vim'


if isdirectory(expand('~/.vim/bundle/L9'))
    if isdirectory(expand('~/.vim/bundle/eclim'))
        MyPlugin 'local/eclim'
    endif
    MyPlugin 'local/fuzzyfinder'
    MyPlugin 'local/vcscommand'
    MyPlugin 'local/ydtrans'
    MyPlugin 'local/maximizer'
    MyPlugin 'local/lookupfile'
    call vundle#end()

    for ifile in allconfs
        exec 'source ' . ifile
    endfor
    unlet allconfs
else
    echomsg "---------------------------------------------"
    echomsg "   Plugins is not downloads!!!"
    echomsg "   Open vim, then exec :PluginInstall"
    echomsg "   Restart vim at last."
    echomsg "---------------------------------------------"
endif
 
"查看映射来自哪里
":verbose imap <tab>

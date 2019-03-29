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

" MyPlugin 'digitalrounin/vim-yaml-folds'
" 最新vim可能导致退出错误 neoyank.vim
" MyPlugin 'Shougo/neoyank.vim'
" MyPlugin 'Shougo/unite-help'
" MyPlugin 'Shougo/unite-outline'
" MyPlugin 'Shougo/tabpagebuffer'
" MyPlugin 'zchee/deoplete-jedi'
" MyPlugin 'Shougo/neoinclude.vim'
" MyPlugin 'tsukkee/unite-tag'
" MyPlugin 'osyo-manga/unite-quickfix'
" MyPlugin 'jalvesaq/Nvim-R'
" 对参数提示功能, 没有jedi做的完善
" MyPlugin 'tenfyzhong/CompleteParameter.vim'
" MyPlugin 'Shougo/deoplete.nvim'
" if !has('nvim')
"     MyPlugin 'roxma/nvim-yarp'
"     MyPlugin 'roxma/vim-hug-neovim-rpc'
" endif
" MyPlugin 'Shougo/neosnippet.vim'
" MyPlugin 'Shougo/neosnippet-snippets'

MyPlugin 'EasyMotion'
MyPlugin 'errormarker.vim'
"rg or ag 可以取代grep.vim
MyPlugin 'grep.vim'
MyPlugin 'Lokaltog/vim-powerline'
if (filereadable('/usr/bin/clang'))
    let g:youcompleteme_enable = 1
    MyPlugin 'Valloric/YouCompleteMe'
    MyPlugin 'davidhalter/jedi-vim'
endif

if (has('lua'))
    MyPlugin 'Shougo/neocomplete.vim'
endif
MyPlugin 'scrooloose/syntastic'
MyPlugin 'scrooloose/nerdtree'
MyPlugin 'Shougo/unite.vim'
MyPlugin 'Shougo/vimproc.vim'
MyPlugin 'Shougo/vimshell.vim'
MyPlugin 'Shougo/neomru.vim'
MyPlugin 'SirVer/ultisnips'
MyPlugin 'honza/vim-snippets'
MyPlugin 'junegunn/fzf'
MyPlugin 'junegunn/fzf.vim'
MyPlugin 'scrooloose/nerdcommenter'
MyPlugin 'majutsushi/tagbar'
MyPlugin 'jlanzarotta/bufexplorer'
MyPlugin 'skywind3000/asyncrun.vim'
MyPlugin 'vim-scripts/DoxygenToolkit.vim'  
MyPlugin 'qrsforever/jupyter-vim'
MyPlugin 'qrsforever/DrawIt'

" Markdown
" vim-pandoc 修改textwidth
MyPlugin 'vim-pandoc/vim-pandoc'
" MyPlugin 'vim-pandoc/vim-pandoc-syntax'
MyPlugin 'jackiehan/vim-instant-markdown'
MyPlugin 'mzlogin/vim-markdown-toc'

" Html, eclim会影响html缩进，可以去除eclim对html的缩进
MyPlugin 'mattn/emmet-vim'
MyPlugin 'ternjs/tern_for_vim'
MyPlugin 'othree/html5.vim'
MyPlugin 'posva/vim-vue'

if isdirectory(expand('~/.vim/bundle/L9'))
    " if isdirectory(expand('~/.vim/bundle/eclim'))
        " MyPlugin 'local/eclim'
    " endif
    MyPlugin 'local/CCTree'
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

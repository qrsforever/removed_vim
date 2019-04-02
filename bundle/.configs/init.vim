" For load plugins

if !isdirectory(expand('~/.vim/bundle/Vundle.vim'))
    echomsg "-------------------------------------------------"
    echomsg "   Need install Vundle plugin, See README.md"
    echomsg "-------------------------------------------------"
    finish
endif

let allconfs = []

"{{{ 定义方法
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
"}}}

call vundle#begin()

"{{{ 必须类
MyPlugin 'VundleVim/Vundle.vim'
MyPlugin 'L9'
"}}}

"{{{ 基础类
MyPlugin 'EasyMotion'
MyPlugin 'errormarker.vim'
MyPlugin 'scrooloose/nerdtree'
MyPlugin 'scrooloose/nerdcommenter'
MyPlugin 'Shougo/vimproc.vim'
MyPlugin 'Shougo/vimshell.vim'
MyPlugin 'majutsushi/tagbar'
MyPlugin 'Lokaltog/vim-powerline'
" 可用LeaderBuffer取代之
" MyPlugin 'jlanzarotta/bufexplorer'
"}}}

"{{{ 搜索类
" LeaderF 取代grep.vim
" MyPlugin 'grep.vim'
" MyPlugin 'junegunn/fzf'
" MyPlugin 'junegunn/fzf.vim'
MyPlugin 'Yggdroot/LeaderF'
MyPlugin 'Shougo/unite.vim'
" MyPlugin 'Shougo/neomru.vim'
"}}}

"{{{ 补全类
if executable('clang')
    let g:youcompleteme_enable = 1
    MyPlugin 'Valloric/YouCompleteMe'
    MyPlugin 'davidhalter/jedi-vim'
endif

if (has('lua'))
    MyPlugin 'Shougo/neocomplete.vim'
endif

MyPlugin 'SirVer/ultisnips'
MyPlugin 'honza/vim-snippets'
"}}}

"{{{ 工具类
MyPlugin 'vim-scripts/DoxygenToolkit.vim'
MyPlugin 'qrsforever/DrawIt'
"}}}

"{{{ 淘汰类
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
"}}}

"{{{ 本地类
" if isdirectory(expand('~/.vim/bundle/eclim'))
    " MyPlugin 'local/eclim'
" endif
MyPlugin 'local/CCTree'
" LeaderF 取代之部分功能
MyPlugin 'local/fuzzyfinder'
MyPlugin 'local/vcscommand'
MyPlugin 'local/ydtrans'
MyPlugin 'local/maximizer'
MyPlugin 'local/lookupfile'
"}}}

"{{{ 未定义类
MyPlugin 'scrooloose/syntastic'
MyPlugin 'skywind3000/asyncrun.vim'
MyPlugin 'qrsforever/jupyter-vim'
"}}}

"{{{ Markdown&Html
" vim-pandoc 修改textwidth
MyPlugin 'vim-pandoc/vim-pandoc'
" MyPlugin 'vim-pandoc/vim-pandoc-syntax'
MyPlugin 'jackiehan/vim-instant-markdown'
MyPlugin 'mzlogin/vim-markdown-toc'

" Html, eclim会影响html缩进，可以去除eclim对html的缩进
" MyPlugin 'mattn/emmet-vim'
" MyPlugin 'ternjs/tern_for_vim'
" MyPlugin 'othree/html5.vim'
" MyPlugin 'posva/vim-vue'
"}}}

call vundle#end()

for ifile in allconfs
    exec 'source ' . ifile
endfor
unlet allconfs

if ! isdirectory(expand('~/.vim/bundle/L9'))
    echomsg "---------------------------------------------"
    echomsg "   Plugins is not downloads!!!"
    echomsg "   Open vim, then exec :PluginInstall"
    echomsg "   Restart vim at last."
    echomsg "---------------------------------------------"
endif

"查看映射来自哪里
":verbose imap <tab>

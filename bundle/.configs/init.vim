" 专门用来对比源插件更新path和入
let g:update_and_diff = 0
let g:fork_maps = {
    \ 'qrsforever/lookupfile': 'vim-scripts/lookupfile',
    \ 'qrsforever/FuzzyFinder': 'vim-scripts/FuzzyFinder',
    \ 'qrsforever/vim-pandoc': 'vim-pandoc/vim-pandoc',
    \ 'qrsforever/DrawIt': 'vim-scripts/DrawIt',
    \ 'qrsforever/jupyter-vim': 'broesler/jupyter-vim',
\}

" For load plugins

if !isdirectory(expand('~/.vim/bundle/Vundle.vim'))
    echomsg "-------------------------------------------------"
    echomsg "   Need install Vundle plugin, See README.md"
    echomsg "-------------------------------------------------"
    finish
endif

let g:allconfs = []
let g:ballpath = expand('$HOME/.vim/bundle')

"{{{ 定义方法
func! s:_AddPlugin(plgname)
    let ss = split(a:plgname, '\/')
    if len(ss) == 2
        let filename = ss[1]
    else
        let filename = ss[0]
    endif
    if g:update_and_diff
        if has_key(g:fork_maps, a:plgname)
            let name = g:fork_maps[a:plgname]
            Plugin name, {'name': join([filename, 'diff'], '_')}
        else
            Plugin a:plgname
        endif
    else
        Plugin a:plgname
    endif
    let inifile = g:ballpath . '/.configs/' . filename . '_conf.vim'
    if filereadable(inifile)
         call add(g:allconfs, inifile)
    endif
endfunction
com! -nargs=*  -bar MyPlugin :call <SID>_AddPlugin(<args>)

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
"}}}

call vundle#begin()

"{{{ 必须类
MyPlugin 'VundleVim/Vundle.vim'
MyPlugin 'vim-scripts/L9'
"}}}

"{{{ 基础类
MyPlugin 'vim-scripts/EasyMotion'
MyPlugin 'scrooloose/nerdtree'
MyPlugin 'scrooloose/nerdcommenter'
MyPlugin 'Shougo/vimproc.vim'
MyPlugin 'Shougo/vimshell.vim'
MyPlugin 'majutsushi/tagbar'
MyPlugin 'Lokaltog/vim-powerline'
"}}}

"{{{ 搜索类
MyPlugin 'Yggdroot/LeaderF'
MyPlugin 'Shougo/unite.vim'
MyPlugin 'qrsforever/lookupfile'
MyPlugin 'qrsforever/FuzzyFinder'
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
MyPlugin 'qrsforever/DrawIt'
MyPlugin 'qrsforever/jupyter-vim'
MyPlugin 'qrsforever/vim-align'
MyPlugin 'vim-scripts/vcscommand.vim'
MyPlugin 'szw/vim-maximizer'
MyPlugin 'iamcco/dict.vim'
MyPlugin 'hari-rangarajan/CCTree'
MyPlugin 'scrooloose/syntastic'
"}}}

"{{{ Markdown&Html
MyPlugin 'qrsforever/vim-pandoc'
MyPlugin 'jackiehan/vim-instant-markdown'
MyPlugin 'mzlogin/vim-markdown-toc'
"}}}

"{{{ 淘汰类
" 可用LeaderBuffer取代之
" MyPlugin 'jlanzarotta/bufexplorer'
" MyPlugin 'errormarker.vim'
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
" MyPlugin 'vim-scripts/DoxygenToolkit.vim'
"
"{{{搜索类
" LeaderF 取代grep.vim
" MyPlugin 'grep.vim'
" MyPlugin 'junegunn/fzf'
" MyPlugin 'junegunn/fzf.vim'
" MyPlugin 'Shougo/neomru.vim'
"}}}
"
" {{{本地类
" if isdirectory(expand('~/.vim/bundle/eclim'))
    " MyPlugin 'qrsforever/eclim'
" endif}}}
"
"{{{ markdown&html
" MyPlugin 'vim-pandoc/vim-pandoc-syntax'
" Html, eclim会影响html缩进，可以去除eclim对html的缩进
" MyPlugin 'mattn/emmet-vim'
" MyPlugin 'ternjs/tern_for_vim'
" MyPlugin 'othree/html5.vim'
" MyPlugin 'posva/vim-vue'}}}
"
" MyPlugin 'skywind3000/asyncrun.vim'
"}}}

call vundle#end()

for ifile in allconfs
    exec 'source ' . ifile
endfor
unlet allconfs
unlet ballpath
unlet update_and_diff
unlet fork_maps

if ! isdirectory(expand('~/.vim/bundle/L9'))
    echomsg "---------------------------------------------"
    echomsg "   Plugins is not downloads!!!"
    echomsg "   Open vim, then exec :PluginInstall"
    echomsg "   Restart vim at last."
    echomsg "---------------------------------------------"
endif

"查看映射来自哪里
":verbose imap <tab>

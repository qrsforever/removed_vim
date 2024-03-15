let s:TYPE_DICT = type({})
let g:allconfs = []
let g:ballpath = expand(g:VIM_HOME . '/bundle')

"{{{ 定义方法
func! s:_AddPlugin(plgname, ...)
    if a:0 ==# 1
        if type(a:1) is s:TYPE_DICT
            Plug a:plgname, a:1
        endif
    else
        Plug a:plgname
    endif
    let ss = split(a:plgname, '\/')
    let inifile = g:VIM_HOME . '/init/' . ss[-1] . '_conf.vim'
    if filereadable(inifile)
         call add(g:allconfs, inifile)
    endif
endfunction
com! -nargs=*  -bar MyPlugin :call <SID>_AddPlugin(<args>)

set nocompatible
filetype off

"}}}

call plug#begin(g:ballpath)

"{{{ 基础类
MyPlugin 'vim-scripts/EasyMotion'
MyPlugin 'preservim/nerdtree'
MyPlugin 'preservim/nerdcommenter'
" MyPlugin 'Xuyuanp/nerdtree-git-plugin'
MyPlugin 'Shougo/vimproc.vim'
MyPlugin 'majutsushi/tagbar'
MyPlugin 'https://gitee.com/qrsforever/vim-powerline'
"}}}

"{{{ 搜索类
MyPlugin 'Yggdroot/LeaderF', {'dir': g:ballpath . '/LeaderF', 'do': './install.sh'}
" MyPlugin 'Shougo/unite.vim'
" MyPlugin 'osyo-manga/unite-quickfix'
" MyPlugin 'qrsforever/lookupfile'
" MyPlugin 'qrsforever/FuzzyFinder'
" MyPlugin 'qrsforever/vim-bookmarks'
"}}}

" {{{ 补全类
" using neovim
" if (v:version >= 801) && has('lua')
"     MyPlugin 'ycm-core/YouCompleteMe'
" else
"     MyPlugin 'Shougo/neocomplete.vim'
" endif

" MyPlugin 'sirver/ultisnips'
" MyPlugin 'honza/vim-snippets'
"}}}

"{{{ 工具类
" if executable('jupyter')
"     " MyPlugin 'https://gitee.com/qrsforever/jupyter-vim'
"     MyPlugin 'jupyter-vim/jupyter-vim'
" endif
" if executable('jsonnet')
"     MyPlugin 'qrsforever/vim-jsonnet'
" endif
" if $RSYNC
"     MyPlugin 'qrsforever/vim-sync'
" endif
" MyPlugin 'https://gitee.com/qrsforever/DrawIt'
" MyPlugin 'skywind3000/asyncrun.vim'
" MyPlugin 'qrsforever/vim-align'
MyPlugin 'vim-scripts/vcscommand.vim'
" MyPlugin 'airblade/vim-gitgutter'
" MyPlugin 'szw/vim-maximizer'
" MyPlugin 'iamcco/dict.vim'
" MyPlugin 'hari-rangarajan/CCTree'
" MyPlugin 'scrooloose/syntastic'

"}}}

"{{{ Markdown&Html
" MyPlugin 'qrsforever/vim-pandoc'
" MyPlugin 'jackiehan/vim-instant-markdown'
" MyPlugin 'qrsforever/vim-markdown-toc'
"}}}

"{{{ 淘汰类
" 可用LeaderBuffer取代之
" MyPlugin 'vim-scripts/DoxygenToolkit.vim'
" vim8.0 above 使用terminal取代
" MyPlugin 'Shougo/vimshell.vim'
" MyPlugin 'vim-scripts/vimim'
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
"}}}

call plug#end()

for ifile in allconfs
    exec 'source ' . ifile
endfor

unlet allconfs
unlet ballpath

"查看映射来自哪里
":verbose imap <tab>

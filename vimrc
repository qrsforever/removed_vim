let mapleader=","
let g:mapleader=","

"==========很多插件，可能进行过修改， 若感觉不爽，可以在.vim搜索lidong， 进行还原===================

"F1~F12快捷键映射"{{{
autocmd!
:mapclear

map <unique> <silent> <F1> <ESC>:MarksBrowser<CR>
map <unique> <silent> <F2> <ESC>:BufExplorer<CR>
map <unique> <silent> <F3> <ESC>:NERDTreeToggle %:p:h<CR>
map <unique> <silent> <F4> <ESC>:TagbarToggle<CR>
map <unique> <silent> <F5> <ESC>:LookupFile<CR>

map <unique> <silent> <F6> <ESC>:MyMake<CR>
map <unique> <silent> <F7> <ESC>:MyGrep<CR>
map <unique> <silent> <F8> <ESC>:MyTags<CR>

map <unique> <silent> <F9> <ESC>:MaximizerToggle<CR>

map <unique> <silent> <F12> <ESC>:ToggleHtmlPhp<CR>

map <unique> <silent> <S-F2> <ESC>:cN<CR>
map <unique> <silent> <S-F3> <ESC>:cn<CR>

map <unique> <silent> <C-F2> <ESC>:tN<CR>
map <unique> <silent> <C-F3> <ESC>:tn<CR>

"S-F2"
map <silent><Esc>O1;2Q <C-O>:cN<CR>
nmap <silent><Esc>O1;2Q :cN<CR>
"S-F3"
map <silent><Esc>O1;2R <C-O>:cn<CR>
nmap <silent><Esc>O1;2R :cn<CR>

"C-F2"
map <silent><Esc>O1;5Q <C-O>:tN<CR>
nmap <silent><Esc>O1;5Q :tN<CR>
"C-F3"
map <silent><Esc>O1;5R <C-O>:tn<CR>
nmap <silent><Esc>O1;5R :tn<CR>

"F1~F12快捷键映射"}}}

"非F1~F12快捷键"{{{
nmap <silent> ga :A<CR>
nmap <silent> <leader>tt :tabnew<CR>

"Quickfix 编译出错信息调试很有用
nmap <silent> <leader>cw :belowright cw 15<CR>
nmap <silent> <C-w>e :belowright cw 15<CR>
"Location list windows 打开
nmap <silent> <leader>lw :belowright lw 15<CR>

nmap cd :lchdir %:p:h<CR>:pwd<CR>

"单手保存 ctrl+s 在BASH中,是Lock the console, 解锁ctrl+q, 解决方法是在.bashrc中添加stty stop '' 或者 alias vim="stty stop ''; vim"
" nmap <C-s> :update<CR>:echo expand('%:p')<CR>
" imap <C-s> <ESC>:<c-u>update<CR>:echo expand('%:p')<CR>
nmap <C-s> :update!<CR>:lchdir %:p:h<CR>:pwd<CR>
imap <C-s> <ESC>:<c-u>update!<CR>:lchdir %:p:h<CR>:pwd<CR>
"非F1~F12快捷键"}}}

"自己定义的命令 "{{{
command XCCTags !ctags --c++-kinds=+p --fields=+ialS --extra=+q -R .
command XRS %s/\s\+$//ge     "消除每行后面的多余的空格
command XRW %s///ge         "消除文件中的^M字符
command XHTML set ft=html
command XPHP  set ft=php
"自己定义的命令 "}}}

"窗口配置"{{{ 
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

"插入模式下的<C-k>系统特殊字符digraphs冲突
imap <C-j> <esc><C-W>j
imap <C-k> <esc><C-W>k
imap <C-h> <esc><C-W>h
imap <C-l> <esc><C-W>l
  
noremap <C-W>v <C-W>v<C-W>l
noremap <C-W>s <C-W>s<C-W>j
"窗口配置"}}}

"简单配置"{{{
"打开语法色彩
syntax enable

"打开关键字色
syntax on

"侦测文件类型
filetype on

"载入文件类型插件
filetype plugin on

"为特定文件类型载入相关缩进文件
filetype indent on

"设置终端支持256颜色
set t_Co=256

"设置VIM颜色主题 你可以借助插件scrollcolor.vim和color_sample_pack.vim来选择你喜爱的主题(150多个)(请参考下面插件)
colorscheme elflord

"预览窗口,eg. ctr+w { 时的窗口大小
set previewheight=20

"设置弹出菜单的高度
set pumheight=15

"使用鼠标
set mouse=a  "在vim里可以用鼠标复制粘贴, 用鼠标左键选中,中键粘贴(中键), shift + 选中:可复制(右键)

"可以在buffer中任意地方使用鼠标
"set selection=exclusive
"set selectmode=mouse,key

"autocmd 如果切换文件, 自动切换当前路径, BufEnter * 会使 eclim插件的JavaImpl冲突
"if has("autocmd")
"  autocmd BufWinEnter * :lchdir %:p:h
"endif
"将当前编辑文件的路径设置为当前路径
" set autochdir
"autocmd

"解决consle输出乱码
language messages zh_CN.utf-8

"可用来改动补全时采用的方式
set wildmode=list:full

"Alt组合键不映射到菜单上
set winaltkeys=no

"可用来取得菜单式的匹配列表 高亮首个匹配
":set wildmenu  "当set wildmode=list:full默认set wildmenu已启动, 但是set wildmode=longest:list时不启动

"设置粘贴模式和恢复
":set paste
":set nopaste

"修改一个文件后，自动进行备份，备份的文件名为原文件名加“~“后缀
"if has("vms")
"    set nobackup
"else
"    set backup  "vim main.c  多出 main.c~文件用来保存打开前的原文件, 最后可用vimdiff main.c main.c~比较
"endif

"写备份但关闭vim后自动删除
set writebackup
"set nowritebackup

"vi兼容开关 当使用omni自动补全时,要设置
"set nocompatible
set nocp

"不使用swap文件
set noswapfile

"关闭遇到错误时的声音提示
set noerrorbells

"不要闪烁
set novisualbell

"使用空格来替换tab
set expandtab

"多标签设置
set showtabline=1 "0表示从不显示标签栏 1表示打开文件多于一个时显示标签栏 2表示总是显示标签栏
set tabpagemax=15 "标签个数

"在vim编辑器下方不显示命令 
""To reduce the number of hit-enter prompts:
"   Set 'cmdheight' to 2 or higher.
"   Add flags to 'shortmess'.
"   Reset 'showcmd' and/or 'ruler'.
set cmdheight=1
set showcmd
" set noshowcmd

"打开 VIM 的状态栏标尺
set ruler
set laststatus=2 "always show

"当光标达到上端或下端时 翻滚的行数
"set scrolljump=3

"当光标达到水平极端时 移动的列数
"set sidescroll=10

"当光标距离极端(上,下,左,右)多少时发生窗口滚动
set scrolloff=2

"当使用vimdiff比较文件,相比较的比较文件同步滚动,但是splite分割窗口, 两个窗口也同步, 有时候挺有用的．
"set scrollbind

"自动读写相关
set autoread              " read open files again when changed outside Vim ( 同步 )
set autowrite             " write a modified buffer on each :next , ... ( 跳到另一个文件时,自动保存上个文件 )
set modified

"设置VIM行号
set nu

"Tab 宽度
set ts=4

"自动缩进的时候, 缩进尺寸
set sw=4

"显示括号配对情况 wrong
set sm  "smartmatch

" 开启新行时使用智能自动缩进
set smartindent

" 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set ignorecase smartcase

" 输入搜索内容时就显示搜索结果
set incsearch

" 搜索时高亮显示被找到的文本
set hlsearch

"use backspace delete a word.
set backspace=indent,eol,start
"indent: 如果用了:set indent,:set ai 等自动缩进,想用退格键将字段缩进的删掉,必须设置这个选项.否则不响应.
"eol:如果插入模式下在行开头,想通过退格键合并两行,需要设置eol.
"start：要想删除此次插入前的输入,需设置这个.

"显示TAB健
" set list
" set listchars=tab:>-,trail:-

"允许backspace和光标键跨越行边界 ( 不习惯 )
"set whichwrap+=<,>,h,l

"内容多时,是否换行显示
set nowrap

" characters to show before wrapped lines
set showbreak=<<>>

"启动的时候不显示那个援助乌干达儿童的提示
set shortmess=aoOWtI

"通过使用: commands命令，告诉我们文件的哪一行被改变过 ( 不习惯 )
" set report=1

"在被分割的窗口间显示空白，便于阅读 (没看到效果)
"stl:\       : 当前窗口状态栏显示'空格' ('\'转义字符)
"stlnc:-     : 非当前窗口状态栏显示---
"vert:\|     : 垂直分割线为|
"fold:-      : 若设置折叠功能,折叠后显示---
"set fillchars=stl:\ ,stlnc:-,vert:\|,fold:-,diff:-
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-
"set fillchars=vert:\ ,stl:\ ,stlnc:\

"带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#

" 中文帮助
" set helplang=cn

" 设定doc文档目录
" let helptags=$VIMFILES.'/doc'

" 保留历史记录
set history=500

" 英文单词在换行时不被截断
set linebreak

" 设置每行多少个字符自动换行，加上换行符
"set textwidth=80 "有时不爽
set textwidth=0  "总不换行

" 光标可以定位在没有实际字符的地方
"set ve=block

"显示匹配的括号([{和}])
set showmatch

" 短暂跳转到匹配括号的时(0.5s)
set matchtime=1

"多少个键被敲下后执行一次交换文件刷新
"set updatecount=40  "设置敲入40个字符后执行

"交换文件刷新后的超时时间
set updatetime=2000  "4秒后刷新
":preserve "若设置的时间过长,该命令会手工的存入交换文件中.

" When using make, where should it dump the file, please see ./bundle/errormarker/conf.vim
" set makeprg=make\ -j4
" set makeprg=ant
set makeef=errors

"lz 如果设置本选项,执行宏,寄存器和其它不通过输入的命令时屏幕不会重画.另外,窗口标题的刷新也被推迟.要强迫刷新,使用:redraw.
"set lz "lazyredraw / 'lz'   (缺省关闭)
" set redrawtime=4000

"过长的行显示不全
set display=lastline

" horiz split new windows below current
set splitbelow
" vert split new windows to right of current
set splitright

"简单配置"}}}

"Gui选项 放到.gvimrc"{{{
set tabline=%!MyTabLine()  " custom tab pages line
if has("gui_running")
   "set noruler
    set guifont=Monospace\ 12  "在Linux下设置字体的命令是：
   "set guicursor=a:blinkon0 "停止光标闪烁
   set guioptions=
   "set guioptions=e    " GUI Tabbar
   "set guioptions+=m   " 菜单栏
   "set guioptions+=T   " 工具栏
   "set guioptions+=b   " 底边滚动条
   "set guioptions+=l   " 左边滚动条
   "set guioptions+=L   " 垂直分隔窗口左边滚动条
   "set guioptions+=r   " 右边滚动条
   "set guioptions+=R   " 垂直分隔窗口右边滚动条
    set mousemodel=popup
    map! <S-Insert> <MiddleMouse>
    "MiddleMouse: 粘贴
    colorscheme spring

    set kp=man\ -P\ more  " remove the [m when using K man help

    map <M-1> 1gt
    map <M-2> 2gt
    map <M-3> 3gt
    map <M-4> 4gt
    map <M-5> 5gt
    map <M-6> 6gt
    map <M-7> 7gt
    map <M-8> 8gt
    map <M-9> 9gt
    map! <M-1> <esc>1gt
    map! <M-2> <esc>2gt
    map! <M-3> <esc>3gt
    map! <M-4> <esc>4gt
    map! <M-5> <esc>5gt
    map! <M-6> <esc>6gt
    map! <M-7> <esc>7gt
    map! <M-8> <esc>8gt
    map! <M-9> <esc>9gt
    " set guitabtooltip=%{GuiTabToolTip()}
    " set guitablabel=%{GuiTabLabel()}
else
    " set tabline=%!MyTabLine()  " custom tab pages line
    nmap g1 1gt
    nmap g2 2gt
    nmap g3 3gt
    nmap g4 4gt
    nmap g5 5gt
    nmap g6 6gt
    nmap g7 7gt
    nmap g8 8gt
    nmap g9 9gt
endif
"Gui选项 放到.gvimrc"}}}

"高亮 注释代码的颜色"{{{
"hi Comment ctermfg=6
"hi cComment ctermfg=LightBlue guifg=LightBlue
"hi cCommentL ctermfg=DarkGray guifg=DarkGray
"高亮 注释代码的颜色"}}}

"高亮 menu color "{{{
highlight Pmenu         ctermbg=LightGreen ctermfg=black    guibg=LightGreen
highlight PmenuSel      ctermbg=LightBlue                   guibg=LightBlue
highlight PmenuSbar     ctermbg=Blue                        guibg=Blue
highlight PmenuThumb    ctermbg=Yellow                      guibg=Yellow
"高亮 menu color "}}}

"高亮 当前行(列)"{{{
set cursorline
set cursorcolumn
" ctermfg : red(1) yellow(2) blue green grey brown cyan magenta 数字
"hi CursorLine   term=none cterm=underline      ctermbg=none    ctermfg=none "  gui=bold      guibg=NONE"
hi CursorLine   term=none cterm=bold      ctermbg=none    ctermfg=none "  gui=bold      guibg=NONE"
hi CursorColumn term=none cterm=bold      ctermbg=none    ctermfg=none "  gui=bold      guibg=NONE"
"高亮 当前行(列)"}}}

"高亮tab标签"{{{
"hi! TabWinNum term=bold,underline cterm=underline gui=bold,underline ctermfg=green guifg=Green ctermbg=darkgrey guibg=DarkGrey
"hi! TabWinNumSel term=bold,underline cterm=underline gui=bold,underline ctermfg=magenta ctermbg=blue guifg=Magenta guibg=#0000ff
"hi! TabPunct term=bold,underline cterm=underline gui=bold,underline ctermfg=cyan guifg=cyan ctermbg=darkgrey guibg=DarkGrey
"hi! TabPunctSel term=bold,underline cterm=underline gui=bold,underline ctermfg=magenta ctermbg=blue guifg=Magenta guibg=#0000ff
hi! TabLineFill ctermfg=darkcyan guifg=darkgrey
hi! TabLineFillEnd ctermfg=lightred ctermbg=black guifg=lightred guibg=black
hi! TabLineSel term=bold ctermfg=blue ctermbg=green gui=bold guifg=blue guibg=green
"hi! TabModded term=underline cterm=underline ctermfg=black ctermbg=yellow gui=underline guifg=black guibg=yellow
"hi! TabExit term=underline,bold ctermfg=red guifg=#ff0000 guibg=darkgrey cterm=underline gui=underline
"hi! TabExitSel gui=underline term=underline,bold guifg=green guibg=blue cterm=underline ctermfg=green ctermbg=blue
"hi! TabSep term=reverse,standout,underline cterm=reverse,standout,underline gui=reverse,standout,underline ctermfg=black ctermbg=white
"高亮tab标签"}}}

"高亮 其他"{{{
"hi statusline cterm=bold ctermfg=LightGreen ctermbg=DarkMagenta gui=bold guifg=Green guibg=DarkMagenta
hi Folded       term=none   cterm=bold    ctermbg=none  ctermfg=none    gui=bold    guibg=NONE
hi FoldColumn   term=none   cterm=bold    ctermbg=none  ctermfg=none    gui=bold    guibg=NONE
hi SignColumn   term=none   cterm=bold    ctermbg=none  ctermfg=none    gui=bold    guibg=NONE
hi VertSplit    term=none   cterm=bold    ctermbg=none  ctermfg=none    gui=bold    guibg=NONE
"高亮 其他"}}}

"字符编码(多字节)"{{{
if has("multi_byte")
    set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
    set termencoding=utf-8
    set encoding=utf-8
    set fileencodings=ucs-bom,utf-8,gb18030,gbk,gb2312,chinese,big5,latin1,cp936
endif
"VIM中显示信息都为英文的.
language en_US.utf8
"字符编码(多字节)"}}}

"打开 C/C++ 风格的自动缩进 ( =a{ , gg=G 代码美化 )
set cin
"设置C/C++语言的具体缩进方式 eg. switch case 缩进"{{{
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set cino=:0g0t0(sus
"工作需要不缩进,不习惯也要习惯
" set cino=:0g0t0(sus
" :0  -- switch 语句之下的 case 语句缩进 0 个空格
" g0  -- class,struct,等权限控制语句(public,protected,private)相对class,struct等所在的块缩进 0 个空格
" t0  -- 如果函数返回值与函数名不在同一行，则返回值缩进 0 个空格
" (sus - 当一对括号跨越多行时，其后的行缩进前面 sw 指定的距离
"设置C/C++语言的具体缩进方式 eg. switch case 缩进"}}}

"vim折叠功能"{{{
"折叠方式,可用选项 ‘foldmethod’ 来设定折叠方式：set fdm=***
"有 6 种方法来选定折叠：
"manual           手工定义折叠
"indent           更多的缩进表示更高级别的折叠
"expr             用表达式来定义折叠
"syntax           用语法高亮来定义折叠
"diff             对没有更改的文本进行折叠
"marker           对文中的标志折叠
"常用的折叠快捷键
"zf  创建折叠 (marker 有效)
"zo  打开折叠
"zO  对所在范围内所有嵌套的折叠点展开
"zc  关闭当前折叠
"zC  对所在范围内所有嵌套的折叠点进行折叠
"[z  到当前打开的折叠的开始处。
"]z  到当前打开的折叠的末尾处。
"zM  关闭所有折叠 (我喜欢)
"zr  打开所有折叠
"zR  循环地打开所有折叠 (我喜欢)
"zE  删除所有折叠
"zd  删除当前折叠
"zD  循环删除 (Delete) 光标下的折叠，即嵌套删除折叠
"za  若当前打开则关闭，若当前关闭则打开  ( 这个就足够了)
"zA  循环地打开/关闭当前折叠
"zj  到下一折叠的开始处 ( 我喜欢 )
"zk  到上一折叠的末尾   ( 我喜欢 )
"set foldmethod=indent
"set foldmarker={,}
"set foldmethod=marker
"要想在{  } 代码块中折叠，按空格键
"syntax 与 c.vim 中的 \cc 注释功能冲突
"set foldmethod=syntax
set foldmethod=marker
set foldenable              " 开始折叠
set foldcolumn=0            " 设置折叠区域的宽度
set foldlevel=0             " 设置折叠层数为
"set foldopen=all
"set foldclose=all           " 设置为自动关闭折叠
"使"用空格打开或关闭折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zC' : 'zO')<CR>
"vim折叠功能"}}}

"文件比较"{{{
    ":vertical diffsplit FILE_RIGHT   "与已打开的文件进行比较
    "设置不同之处显示上下三行
    set diffopt=context:3
    "命令模式（ESC键进入）：
    "[c  跳转到下一个差异点
    "]c  跳到上一个差异点
    "dp  左边文件差异复制到右边文件(直接在键盘上行按下dp)
    "do  右边文件差异复制到左边文件(直接在键盘上行按下do)
    "zo  隐藏相同行
    "zc  展开向同行
    "u 撤销
    "Ctrl+ww  文件切换
    "
    ":qa! 退出不保存
    ":wa  保存
    ":wqa 保存退出
    ":diffupdate 重新比较
"文件比较"}}}

"单词列表匹配"{{{
"ctrl+x ctrl+k
"apt-get install wordlist
set dictionary=~/.vim/dict/wordlist.txt
" set cpt=.,b,t,k
" set cpt=.
"    .	scan the current buffer ('wrapscan' is ignored)
"    w	scan buffers from other windows
"    b	scan other loaded buffers that are in the buffer list
"    u	scan the unloaded buffers that are in the buffer list
"    U	scan the buffers that are not in the buffer list
"    k	scan the files given with the 'dictionary' option
"    kspell  use the currently active spell checking |spell|
"    k{dict}	scan the file {dict}.  Several "k" flags can be given,
"       patterns are valid too.  For example: >
"           :set cpt=k/usr/dict/*,k~/spanish
"    s	scan the files given with the 'thesaurus' option
"    s{tsr}	scan the file {tsr}.  Several "s" flags can be given, patterns
"       are valid too.
"    i	scan current and included files
"    d	scan current and included files for defined name or macro
"       |i_CTRL-X_CTRL-D|
"    ]	tag completion
"    t	same as "]"
"单词列表匹配"}}}

"打开文件后自动回到上一次最后编辑的地方"{{{
"如果不起作用查看 ~/.viminfo 文件属性
au BufReadPost *
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ exe "normal! g'\"" |
 \ endif
"打开文件后自动回到上一次最后编辑的地方"}}}

"completeopt 弹出菜单 输入字母实现即时的过滤和匹配 ( 参考 neocomplcache  )"{{{
""关掉智能补全时的预览窗口 (Scratch)
"" menu     使用弹出菜单来显示可能的补全
"" longest  只插入匹配的最长公共文本
""set completeopt=menuone,menu,longest,preview
set completeopt=menu
"set completeopt=menu,longest
"completeopt 弹出菜单 输入字母实现即时的过滤和匹配 ( 参考 neocomplcache  )"}}}

"----------------------
"利用 插件 丰富 功能
"----------------------

"a.vim实现源文件与头文件切换
let alternateNoDefaultAlternate = 1

"Set Tags database : tags cscope filenametags
source ~/.vim/bundle/tagdbs/conf.vim
source ~/.vim/bundle/myfunc/conf.vim

"Set PHP
source ~/.vim/bundle/php/conf.vim

"pathogen脚本运行环境,更新插件相当方便
call pathogen#infect()

"FuzzyFinder fuf.vim模糊查找 (功能之一： 查找并打开最近修改的文件， 相当方便)
source ~/.vim/bundle/fuzzyfinder/conf.vim

"Shougo的unite插件，和fuzzyfinder功能相似， 尝试一下
source ~/.vim/bundle/unite/conf.vim

"NERD_commenter.vim 
source ~/.vim/bundle/nerdcommenter/conf.vim

"单独切换打开NERD_tree(目录树)
source ~/.vim/bundle/nerdtree/conf.vim

"neocomplete 如果不支持内嵌lua，~/.vim/src有lua的源码，编译一下，重新编译vim指定lua静态库位置
source ~/.vim/bundle/neocomplete/conf.vim

"neosnippet.vim (代码片段补全)
source ~/.vim/bundle/neosnippet/conf.vim

"vimshell.vim (在vim中使用终端)
source ~/.vim/bundle/vimshell/conf.vim

"omnicppcomplete.vim (c/c++补全)
source ~/.vim/bundle/omnicppcomplete/conf.vim

"code_complete.vim (功能提示补全, 可以废掉)
source ~/.vim/bundle/code_complete/conf.vim

"PowerLine.vim 状态栏更绚丽
source ~/.vim/bundle/powerline/conf.vim

"lookupfile插件默认会使用ctags产生的tag来查找，效率很低,使用下面脚本生成filenametags
source ~/.vim/bundle/lookupfile/conf.vim

"CCtree.Vim  C Call-Tree Explorer 源码浏览工具 关系树 (赞)
source ~/.vim/bundle/cctree/conf.vim

"tagbar 样式比taglist好看
source ~/.vim/bundle/tagbar/conf.vim

"errormarker.vim (可以快速定位工程中出错的文件)
source ~/.vim/bundle/errormarker/conf.vim

"vcscommand 各种版本控制 svn cvs git hg
source ~/.vim/bundle/vcscommand/conf.vim

"F7 Grep.vim 查找字符 (也可以使用Unite的部分功能， 不过这个简单实用)
source ~/.vim/bundle/grep/conf.vim

"ft-cmake for CMakeLists.txt
source ~/.vim/bundle/ft-cmake/conf.vim

"maximizer.vim (分割多个窗口时， 可以只用这个将某个窗口最大化)
source ~/.vim/bundle/maximizer/conf.vim

"使用有道翻译
source ~/.vim/bundle/ydtrans/conf.vim

"Text中快速移动，让你在没有鼠标的时侯不失速度
source ~/.vim/bundle/easymotion/conf.vim

"DrawIt 在vim中轻松绘图
" source ~/.vim/bundle/DrawIt/conf.vim

"eclim 再也不用担心Android开发了"
source ~/.vim/bundle/eclim/conf.vim

"Sessionman
" source ~/.vim/bundle/sessionman/conf.vim

"目录文件对比
" source ~/.vim/bundle/DirDiff/conf.vim

" 被废弃的插件，很怀念
"neocomplcache.vim
"source ~/.vim/bundle/neocomplcache/conf.vim
"
""ctrlspace.vim
""source ~/.vim/bundle/ctrlspace/conf.vim
"
""GoldenView 窗口切割编辑利器
"source ~/.vim/bundle/GoldenView/conf.vim
"
"clang_complete.vim
"source ~/.vim/bundle/clang_complete/conf.vim
"
"xmlEditor 
" source ~/.vim/bundle/xmledit/conf.vim
"
"altercmd 为命令定义别名, eg: adi --> Ant debug install 
"

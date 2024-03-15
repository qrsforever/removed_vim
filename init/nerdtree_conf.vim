"{{{ Setup
"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" :ERDtree 打开NERD_tree         :NERDtreeClose    关闭NERD_tree
" o 打开关闭文件或者目录         t 在标签页中打开
" T 在后台标签页中打开           ! 执行此文件
" p 到上层目录                   P 到根目录
" K 到第一个节点                 J 到最后一个节点
" u 打开上层目录                 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录             R 递归刷新当前根目录
"-----------------------------------------------------------------
"loaded_nerd_tree            不使用NerdTree脚本
"NERDChristmasTree           让Tree把自己给装饰得多姿多彩漂亮点
"NERDTreeAutoCenter          控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
"NERDTreeAutoCenterThreshold 与NERDTreeAutoCenter配合使用
"NERDTreeCaseSensitiveSort   排序时是否大小写敏感
"NERDTreeChDirMode           确定是否改变Vim的CWD(0,1,2)
"NERDTreeHighlightCursorline 是否高亮显示光标所在行
"NERDTreeHijackNetrw         是否使用:edit命令时打开第二NerdTree
"NERDTreeIgnore              默认的“无视”文件
"NERDTreeBookmarksFile       指定书签文件
"NERDTreeMouseMode           指定鼠标模式（1.双击打开；2.单目录双文件；3.单击打开）
"NERDTreeQuitOnOpen          打开文件后是否关闭NerdTree窗口
"NERDTreeShowBookmarks       是否默认显示书签列表
"NERDTreeShowFiles           是否默认显示文件
"NERDTreeShowHidden          是否默认显示隐藏文件
"NERDTreeShowLineNumbers     是否默认显示行号
"NERDTreeSortOrder           排序规则
"NERDTreeStatusline          窗口状态栏
"NERDTreeWinPos              窗口位置（'left' or 'right'）
"NERDTreeWinSize             窗口宽
let g:NERDTreeHijackNetrw=0
let g:NERDChristmasTree=0
let g:NERDTreeAutoCenter=1
let g:NERDTreeAutoCenterThreshold=3
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeMouseMode=1
let g:NERDTreeShowBookmarks=0
let g:NERDTreeShowFiles=1
let g:NERDTreeShowHidden=0
let g:NERDTreeShowLineNumbers=0
let g:NERDTreeWinPos='left'
let g:NERDTreeWinSize=36
let g:NERDTreeStatusline=1
let g:NERDTreeChDirMode=2
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeDirArrows=1
" files to ignore "
let g:NERDTreeIgnore = ['.*\.o$']
let g:NERDTreeIgnore += ['.*\.bak$']
let g:NERDTreeIgnore += ['.*\.out$', '.*__pycache__$']
let g:NERDTreeIgnore += ['.*\.so$', '.*\.a$', '.*\.dll$']
" audio/video "
let g:NERDTreeIgnore += ['.*\.ogv$', '.*\.ogg$', '.*\.mp3$', '.*\.avi$']
let g:NERDTreeIgnore += ['.*\.mp4$', '.*\.wmv$', '.*\.wma$', '.*\.mp([eE])?g$']
" pics "
let g:NERDTreeIgnore += ['.*\.[pP][nN][gG]$', '.*\.[jJ][pP][gG]$', '.*\.[gG][iI][fF]$']
" tarballs "
let g:NERDTreeIgnore += ['.*\.bz2$', '.*\.gz$', '.*\.tar$', '.*\.zip$', '.*\.tgz$', '.*\.rar$']
" packages "
let g:NERDTreeIgnore += ['.*\.deb$', '.*\.ipk$', '.*\.rpm$', '.*\.tbz$']" flash "
let g:NERDTreeIgnore += ['.*\.[sS][wW][fF]$']
" libtool archives and objs "
let g:NERDTreeIgnore += ['.*\.lo$', '.*\.la']
" java's binary files "
let g:NERDTreeIgnore += ['.*\.class']
" tags "
let g:NERDTreeIgnore += ['tags']

" nnoremap <silent> <leader>f :NERDTreeToggle<CR>
" o.......打开所选文件或目录    ( 常用 )
" enter..............相当于o
" go......类似o, 但光标仍然停留在NERD_tree  ( 常用 )
" t.......在新标签中打开所选文件
" T.......类似t, 但光标仍然停留在NERD_tree
" i.......在一个水平分割窗口中打开文件
" gi......类似i, 但光标仍然停留在NERD_tree
" s.......在一个垂直分割窗口中打开文件.......................|NERDTree-s|
" gs......类似s, 但光标仍然停留在NERD_tree
" O.......递归打开所选目录
" 鼠标双击.......相当于o, 没错支持鼠标的~!

let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

"}}}

function! s:DoNERDTreeOpenToggle(cwd) "{{{
    " let l:win = winlayout()
    " if len(l:win) == 2 && l:win[0] == "row"
    "    if bufname(winbufnr(l:win[1][0][1])) =~ "NERD_tree_"
    "        echo "opened"
    "    endif
    " endif

    if a:cwd == 1
        exec 'lchdir %:p:h'
        exec 'NERDTreeToggle ' . getcwd()
    else
        exec 'NERDTreeToggle'
    endif
endfunction "}}}

nmap <silent> s[ :call <SID>DoNERDTreeOpenToggle(1)<CR>
nmap <silent> s{ :call <SID>DoNERDTreeOpenToggle(0)<CR>

" 打开一个空文件时自动开启
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

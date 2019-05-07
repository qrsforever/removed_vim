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
let NERDTreeHijackNetrw=0                            "使用:edit命令时只打开一个NerdTree
let NERDChristmasTree=0                              "让Tree把自己给装饰得多姿多彩漂亮点
let NERDTreeAutoCenter=1                             "控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
let NERDTreeAutoCenterThreshold=3
let NERDTreeHighlightCursorline=1                    "是否高亮显示光标所在行
let NERDTreeMouseMode=1                              "指定鼠标模式
let NERDTreeShowBookmarks=0                          "默认显示书签列表
let NERDTreeShowFiles=1                              "默认显示文件
let NERDTreeShowHidden=0                             "默认not显示隐藏文件
let NERDTreeShowLineNumbers=0                        "默认是否显示行号
let NERDTreeWinPos='left'                            "窗口位置left
let NERDTreeWinSize=36                               "窗口宽
let NERDTreeStatusline=1
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=0
let NERDTreeDirArrows=1
" files to ignore "
let NERDTreeIgnore = ['.*\.o$']
let NERDTreeIgnore += ['.*\.bak$']
let NERDTreeIgnore += ['.*\.out$', '.*__pycache__$']
let NERDTreeIgnore += ['.*\.so$', '.*\.a$', '.*\.dll$']
" audio/video "
let NERDTreeIgnore += ['.*\.ogv$', '.*\.ogg$', '.*\.mp3$', '.*\.avi$']
let NERDTreeIgnore += ['.*\.mp4$', '.*\.wmv$', '.*\.wma$', '.*\.mp([eE])?g$']
" pics "
let NERDTreeIgnore += ['.*\.[pP][nN][gG]$', '.*\.[jJ][pP][gG]$', '.*\.[gG][iI][fF]$']
" tarballs "
let NERDTreeIgnore += ['.*\.bz2$', '.*\.gz$', '.*\.tar$', '.*\.zip$', '.*\.tgz$', '.*\.rar$']
" packages "
let NERDTreeIgnore += ['.*\.deb$', '.*\.ipk$', '.*\.rpm$', '.*\.tbz$']" flash "
let NERDTreeIgnore += ['.*\.[sS][wW][fF]$']
" libtool archives and objs "
let NERDTreeIgnore += ['.*\.lo$', '.*\.la']
" java's binary files "
let NERDTreeIgnore += ['.*\.class']
" tags "
let NERDTreeIgnore += ['tags']

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

"}}}

function! s:DoNERDTreeOpenToggle() "{{{
    let cwd1 = getcwd()
    exec 'lchdir %:p:h'
    let cwd2 = getcwd()
    
    if cwd1 != cwd2
        exec 'NERDTreeCWD'
    else
        if g:NERDTree.IsOpen()
            exec 'NERDTreeClose'
        else
            " exec 'NERDTreeFind'
            exec 'NERDTreeCWD'
        endif
    endif
endfunction "}}}

nmap <silent> so :call <SID>DoNERDTreeOpenToggle()<CR>

" 打开一个空文件时自动开启
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

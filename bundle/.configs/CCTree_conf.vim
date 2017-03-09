"1. 除了cscope ctags 程序的安装,还需安装强力胶 ccglue(ctags-cscope glue): http://sourceforge.net/projects/ccglue/files/src/
"    (1) ./configure  &&  make  && make install  (或直接下载ccglue放到/bin中
"    (2) ccglue -S cscope.out -o cctree.out
"    (3) :CCTreeLoadXRefDBFromDisk cctree.out
"2. 映射快捷键(上面F1) 其中$CCTREE_DB是环境变量,写在~/.bashrc中
"   map <F1> :CCTreeLoadXRefDBFromDisk $CCTREE_DB<CR>
"    eg.
"        export CSCOPE_DB=/home/tags/cscope.out
"        export CCTREE_DB=/home/tags/cctree.out
"        export MYTAGS_DB=/home/tags/tags

"   "注: 如果没有装ccglue ( 麻烦且快捷键不好设置,都用完了 )
"        (1) map <leader>xxx :CCTreeLoadDB $CSCOPE_DB<CR>              "这样加载有点慢, cscope.out cctree.out存放的格式不同
"        (2) map <leader>xxx :CCTreeAppendDB $CSCOPE_DB2<CR>           "追加另一个库
"        (3) map <leader>xxx :CCTreSaveXRefDB $CSCOPE_DB<CR>           "格式转化xref格式
"        (4) map <leader>xxx :CCTreeLoadXRefDB $CSCOPE_DB<CR>          "加载xref格式的库 (或者如下)
"            map <leader>xxx :CCTreeLoadXRefDBFromDisk $CSCOPE_DB<CR>  "加载xref格式的库
"        (5) map <leader>xxx :CCTreeUnLoadDB                           "卸载所有的数据库
"3. 设置
let g:CCTreeDisplayMode = 2     " 当设置为水平显示时, 模式为3最合适. (1-minimum width, 2-little space, 3-witde)
let g:CCTreeWindowVertical = 0   " 0:水平分割
let g:CCTreeWindowHeight = 20     "Horizontal window,  default is -1
let g:CCTreeWindowMinWidth = 40  " 最小窗口
let g:CCTreeUseUTF8Symbols = 1   " 为了在终端模式下显示符号
let g:CCTreeKeyToggleWindow = '<C-\>w'  "打开关闭窗口
let g:CCTreeHilightCallTree = 1  " 高亮, 太耀眼.
let g:CCTreeEnhancedSymbolProcessing = 0 
let g:CCTreeOrientation = "rightbelow" "Orientation of window(standard vim options for split: [right|left][above|below])

let g:CCTreeRecursiveDepth  = 3 "Maximum call levels,   
let g:CCTreeMinVisibleDepth = 3 "Maximum visible(unfolded) level, 

"默认设置:
"let g:CCTreeKeyTraceForwardTree = '<C-\>>' "该函数调用其他函数
"let g:CCTreeKeyTraceReverseTree = '<C-\><' "该函数被谁调用
"g:CCTreeKeyHilightTree = '<C-l>'        " Static highlighting

"g:CCTreeKeySaveWindow = '<C-\>y'
"g:CCTreeKeyToggleWindow = '<C-\>w'
"g:CCTreeKeyCompressTree = 'zs'     " Compress call-tree
"g:CCTreeKeyDepthPlus = '<C-\>='
"g:CCTreeKeyDepthMinus = '<C-\>-'
"
"当查看源码是使用 -- 插件 : Cscope_map.vim
"是否使用 quickfix 窗口来显示 cscope 结果
set cscopequickfix=s-,c-,d-,i-,t-,e-
"echo "export CSCOPE_DB=/home/tags/cscope.out" >> ~/.bashrc
"------- 下面是对cscope_map.vim文件的部分翻译
""0 或 s  查找C语言符号，即查找函数名、宏、枚举值等出现的地方 (可以跳过注释)
""1 或 g  查找本定义 --可以到函数的定义处
""2 或 d  查找本函数调用的函数 
""3 或 c  查找调用本函数的函数 --该函数被谁调用
""4 或 t  查找本字符串
""6 或 e  查找本 egrep 模式
""7 或 f  查找本文件
""8 或 i  查找包含本文件的文件
""ctrl + o 可以返回
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"
"window tab 
nmap <C-\><C-\>s :tab cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>g :tab cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>c :tab cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>t :tab cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>e :tab cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>f :tab cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\><C-\>i :tab cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\><C-\>d :tab cs find d <C-R>=expand("<cword>")<CR><CR>

""window split horizontally <C-@> 在gvim有些冲突
nmap <C-\>\s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>\g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>\c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>\t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>\e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>\f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>\i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>\d :scs find d <C-R>=expand("<cword>")<CR><CR>
"
""window split vertically <C-@><C-@> 在gvim有些冲突
nmap <C-\>/s :vert scs cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>/g :vert scs cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>/c :vert scs cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>/t :vert scs cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>/e :vert scs cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>/f :vert scs cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>/i :vert scs cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>/d :vert scs cs find d <C-R>=expand("<cword>")<CR><CR>
"
"
"""使用方法
"""生成一个 cscope 的数据库
"""1.cd /usr/src/linux/
"""2.cscope -Rbq
"""cs add /usr/src/linux/cscope.out /usr/src/linux/
"""reset : 重新初始化所有连接. 用法  : cs reset
"""
"""1.下載cscope包 http://cscope.sourceforge.net/
"""2.安裝cscope A../configure B.make C.make install
"""3.修改set csprg 位置 ：/usr/local/bin/cscope
"""4.F3
"""5.测试（1）cscope find g 函数名 （2） cscope find c 函数名
"""6. :cw 显示多个结果
"""
"""下面是shell脚本，放到源码目录下运行
"""#!/bin/sh
"""find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files
"""cscope -bcq -i cscope.files
"""ctags -R
"""上面是shell脚本，放到源码目录下运行
"""
"""下面是对cscope -Rbkq 的解释
"""-R: 在生成索引文件时，搜索子目录树中的代码
"""-b: 只生成索引文件，不进入cscope的界面
"""-k: 在生成索引文件时，不搜索/usr/include目录 注意：如果使用ccglue生成数据库，不要这个参数
"""-q: 生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度
"""-I: 在-I选项指出的目录中查找头文件
"""-u: 扫描所有文件，重新生成交叉索引文件
"""-C: 在搜索时忽略大小写
"""
"""cscope和ctags的兼容问题
if has("cscope")
	" set csprg=/usr/bin/cscope
	set cscopetag   "具有Ctags快捷键功能eg. ctrl+] , ctrl + t
    set csto=1      "先使用ctags再使用cscope
    set nocscopeverbose  "不显示信息
    set notimeout
    "if filereadable($DEFAULT_CSCOPE)
    "    cs add $DEFAULT_CSCOPE
    "endif
    "if filereadable($MID_CSCOPE)
    "    cs add $MID_CSCOPE
    "endif
    "if filereadable($SDK_CSCOPE)
    "    cs add $SDK_CSCOPE
    "endif
endif
"""cscope和ctags的兼容问题
"":help if_cscop.txt
"":cs show

"========TAG
command! -nargs=* MyTagL0 call s:LoadTagDB(0)
command! -nargs=* MyTagL1 call s:LoadTagDB(1)
command! -nargs=* MyTagL2 call s:LoadTagDB(2)
command! -nargs=* MyTags  call s:DoSelectTagDB()

func! s:LoadTagDB(force) 
    exec 'lchdir %:p:h'
    let root = getcwd()
    let flg = str2nr(a:force, 10) 
    if flg == 1
        let dbfile = s:FindTagDB(root)
    else
        let dbfile = s:DeleteTagDB(root) 
    endif
    if flg == 0
        return
    endif
    if empty(dbfile)
        let dbfile = s:CreateTagDB(root)
    endif
    exec 'source ' . dbfile
    exec "redraw"
    echomsg "Use TagDB: " . dbfile
endfunc

func! s:FindTagDB(root) 
    let path = a:root
    while 1 < len(path)
        let dbfile = '/tmp/tags' . path . '/.tags/db.vim'
        if filereadable(dbfile)
            return dbfile
        endif
        let path = fnamemodify(path, ':h')
    endwhile
    return ''
endfunction

func! s:DeleteTagDB(root) 
    let path = a:root
    while 1 < len(path)
        let dir = '/tmp/tags' . path . '/.tags'
        if isdirectory(dir)
            call system("rm " . ' -rf ' . dir)
        endif
        let path = fnamemodify(path, ':h')
    endwhile
    return ''
endfunction

func! s:CreateTagDB(root) 
    let dbrun = '~/.vim/bin/0db.sh'
    let inputdir = substitute(input("TagDB dir: ", a:root, "dir"), '\/$', '', '')
    let tagsdir = '/tmp/tags' . inputdir . '/.tags'
    if !isdirectory(tagsdir)
        call mkdir(tagsdir, 'p')
    endif
    echomsg "Build TagDB: " . inputdir
    exec '!' . dbrun . ' ' . tagsdir . ' ' . inputdir
    return tagsdir . '/db.vim'
endfunction

func! s:DoSelectTagDB()
    let tagdir = $tags
    if len(tagdir) == 0
        echomsg 'set env tags dir, you can add export tags=your_tag_dir into ~/.profile'
        echomsg ' 1. 创建一个专门存放不同工程总Tag的目录 '
        echomsg '    eg. mkdir -p /home/lidong/Workspace/tags '
        echomsg ' 2. 设置系统环境变量tags指向总Tag的目录'
        echomsg '    eg. export tags=/home/lidong/Workspace/tags (可以写到~/.profile) '
        echomsg ' 3. 增加需要创建Tag的不同工程的目录 '
        echomsg '    eg. mkdir -p /home/lidong/Workspace/tags/myproject1 '
        echomsg ' 4. 在工程目录中创建db.sh, 指定工程源码路径即可'
        echomsg '    db.sh内容可参考~/.vim/bin/db.sh '
        echomsg ' 5. 在工程目录里, 执行./db.sh生成需要的tags, filenametags, cscope'
        echomsg '    eg. cd /home/lidong/Workspace/tags/myproject1; ./db.sh '
        return
    endif
    echomsg "   Input 0(Build DB) or  88 (libc) or 99 (cpp)"
    let subdirs = [ ]
    if vimshell#util#has_vimproc()
        let dirs = vimproc#readdir(tagdir)
        let i = 0
        for subdir in dirs
            let i = i + 1
            let subdir = substitute(subdir, '\/$', '', '')
            if isdirectory(subdir)
                echomsg ' ' . i . ' ' . subdir
                call add(subdirs, subdir)
            endif
        endfor

        echohl Search
        let tmpstr = input("Select TagDB: ", ' ')
        echohl None
        let tokpos = stridx(tmpstr, '+')
        if tokpos > 0
            let select = str2nr(strpart(tmpstr, tokpos+1), 10)         
        else 
            set tags=./tags
            let select = str2nr(tmpstr, 10)         
        endif
        echomsg ' '

        if select > i || i == 0 || select == 0
            if select == 0
                echomsg "1: MyTagL1(only load) 2: MyTagL2(delete before load) 3: MyTagL0(delete)"
                echohl Search
                let res = str2nr(input("Select : ", ' '), 10)
                echohl None
                if res == 1
                    exec "MyTagL1"
                elseif res == 2
                    exec "MyTagL2"
                elseif res == 3
                    exec "MyTagL0"
                else
                    return
                endif
            elseif select == 99
                set tags+=~/.vim/tags/include.tags
                set tags+=~/.vim/tags/cpp.tags
                echomsg ' tags: cpp include!'
            elseif select == 88
                set tags+=~/.vim/tags/libc.tags
                set tags+=~/.vim/tags/glib.tags
                echomsg ' tags: libc glib!'
            else 
                echomsg ' Not found db.vim!'
            endif
            return
        endif

        let select = select -1

        " commont off templatly.
        " set tags+=~/.vim/tags/include.tags
        " set tags+=~/.vim/tags/cpp.tags

        let dbfile = subdirs[select] . '/db.vim'
        if filereadable(dbfile)
            exec 'source ' . dbfile
            exec "redraw"
        else 
            echomsg ' Not found db.vim!'
            return 
        endif
    endif
endfunc

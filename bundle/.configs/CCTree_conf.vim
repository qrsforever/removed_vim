" CCTree Setup {{{
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
let g:CCTreeUseUTF8Symbols = 1

let g:CCTreeRecursiveDepth  = 3 "Maximum call levels,
let g:CCTreeMinVisibleDepth = 3 "Minimum visible(unfolded) level,

"默认设置: (版本问题, 若出现功能错误, 把cctree.out第#0及下一行删除
" let g:CCTreeKeyTraceForwardTree = '<C-\>>' "该函数调用其他函数
" let g:CCTreeKeyTraceReverseTree = '<C-\><' "该函数被谁调用
" let g:CCTreeKeyHilightTree = '<C-l>'        " Static highlighting
" let g:CCTreeKeySaveWindow = '<C-\>y'
" let g:CCTreeKeyToggleWindow = '<C-\>w'
" let g:CCTreeKeyCompressTree = 'zs'     " Compress call-tree
" let g:CCTreeKeyDepthPlus = '<C-\>='
" let g:CCTreeKeyDepthMinus = '<C-\>-'

"当查看源码是使用 -- 插件 : Cscope_map.vim
"是否使用 quickfix 窗口来显示 cscope 结果
set cscopequickfix=s-,c-,d-,i-,t-,e-
"echo "export CSCOPE_DB=/home/tags/cscope.out" >> ~/.bashrc
func! CCTreeOpenFile(cmd, flag) "{{{
    let line = ''
    if a:flag == 1
        let pattern = getreg("*")
        if len(pattern) < 3 || len(pattern) > 48
            echomsg "file is too short/long[1]"
            exec 'LUTags ' . pattern
            return
        endif
        " res[0]是匹配的字符串, res[1]/res[2]匹配的正则表达式内容
        try
            let res = matchlist(pattern, '\s*\([^:]\+\):\~*\(\d*\).*$')
            " echomsg "res[1] " . res[1] . "  res[2]: " . res[2]
        catch
            " echomsg "len: " . len(res)
        endtry
        if !empty(res) && res[1] != '' && res[2] != ''
            let pattern = res[1]
            let line = res[2]
        endif
    else
        " 区分: path1.path2.file and file.function
        " help \v: very magic, 有些不需用'\'进行转义了.
        " accept file:line:xxx or file:line.xxx
        " ';' matchlist有没有匹配都会返回10个, 这个';'可以抑制个数不对的错误
        try
            let [_, pattern, line; __] = matchlist(getline("."), '\v.*(' . expand('<cfile>') . ')\s*:\~*(\d*).*$')
            " echomsg "file1: " . pattern . "  line:" . line
        catch
            " echomsg "file2: " . pattern . "  line:" . line
        endtry
    endif
    if len(pattern) < 3
        echomsg "file is too short"
        exec 'LUTags ' . pattern
        return
    endif
    " 如果路径完整, 直接跳转
    if filereadable(pattern)
        exec 'tabedit ' . pattern
        if line != ''
            exec line
        endif
    else
        try
            exec a:cmd . ' find f ' . pattern
            if line != ''
                exec line
            endif
        catch
            echomsg "[".  pattern . "] not found!"
            exec 'LUTags ' . pattern
            return
        endtry
    endif
endfunc "}}}

" 使用Unite output/shellcmd 执行grep, 需要先cs connect
func! CCTreeEGrep(pattern) "{{{
    try
        redir => result
        silent! execute 'cs show'
        redir END
        " let sources = ""
        let cmd = "grep " . a:pattern . " `cat "
        let dbs = ""
        for line in split(result, "\n")[2:]
            " let sources = sources . join(readfile(split(line)[3] . "/cscope.files"), "\n")."\n"
            let dbs = dbs . split(line)[3] . "/cscope.files\\\ "
        endfor
        if dbs != ""
            execute "Unite -buffer-name=shellcmd output/shellcmd:cat\\\ " . dbs . "|xargs\\\ grep\\\ -n\\\ \"" . a:pattern . "\""
        else
            echomsg "no dbs"
        endif
    catch
        echomsg "no dbs"
    endtry
endfunc "}}}

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
endif
"""cscope和ctags的兼容问题
"":help if_cscop.txt
"":cs show

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
"}}}

nmap <C-\>> :CCTreeTraceForward <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>< :CCTreeTraceReverse <C-R>=expand("<cword>")<CR><CR>

"局部跳转到赋值或定义处:gd, cs a 是去全局
"" current buffer
nmap <unique> <silent> <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <unique> <silent> <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>f :call CCTreeOpenFile('tab cs', 0)<CR>
nmap <unique> <silent> <C-\>E :call CCTreeEGrep(expand("<cword>"))<CR>

""window split horizontally <C-@> 在gvim有些冲突
nmap <unique> <silent> <C-\>]a :scs find a <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>]s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>]g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>]c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>]t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>]e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>]i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <unique> <silent> <C-\>]d :scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>]f :call CCTreeOpenFile('scs', 0)<CR>
"
""window split vertically <C-@><C-@> 在gvim有些冲突
nmap <unique> <silent> <C-\>[a :vert scs find a <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>[s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>[g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>[c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>[t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>[e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>[i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <unique> <silent> <C-\>[d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <silent> <C-\>[f :call CCTreeOpenFile('vert scs', 0)<CR>

"" using selection register
nmap <unique> <silent> <C-\><C-\>a :cs find a <C-R>=expand(getreg("*"))<CR><CR>
nmap <unique> <silent> <C-\><C-\>s :cs find s <C-R>=expand(getreg("*"))<CR><CR>
nmap <unique> <silent> <C-\><C-\>g :cs find g <C-R>=expand(getreg("*"))<CR><CR>
nmap <unique> <silent> <C-\><C-\>c :cs find c <C-R>=expand(getreg("*"))<CR><CR>
nmap <unique> <silent> <C-\><C-\>t :cs find t <C-R>=expand(getreg("*"))<CR><CR>
nmap <unique> <silent> <C-\><C-\>e :cs find e <C-R>=expand(getreg("*"))<CR><CR>
nmap <unique> <silent> <C-\><C-\>i :cs find i ^<C-R>=expand(getreg("*"))<CR>$<CR>
nmap <unique> <silent> <C-\><C-\>d :cs find d <C-R>=expand(getreg("*"))<CR><CR>
nmap <unique> <silent> <C-\><C-\>f :call CCTreeOpenFile('tab cs', 1)<CR>

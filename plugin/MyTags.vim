func! s:LoadTagDB(force, root) "{{{
    let flg = str2nr(a:force, 10) 
    if flg == 1
        let dbfile = s:FindTagDB(a:root)
    else
        let dbfile = s:DeleteTagDB(a:root) 
    endif
    if flg == 0
        return
    endif
    if empty(dbfile)
        let dbfile = s:CreateTagDB(a:root)
    endif
    exec 'source ' . dbfile
    exec "redraw"
    echomsg "Use TagDB: " . dbfile
endfunc "}}}

func! s:FindTagDB(root) "{{{
    let path = a:root
    while 1 < len(path)
        let dbfile = '/tmp/tags' . path . '/.tags/db.vim'
        if filereadable(dbfile)
            return dbfile
        endif
        let path = fnamemodify(path, ':h')
    endwhile
    return ''
endfunc "}}}

func! s:DeleteTagDB(root) "{{{
    let path = a:root
    while 1 < len(path)
        let dir = '/tmp/tags' . path . '/.tags'
        if isdirectory(dir)
            call system("rm " . ' -rf ' . dir)
        endif
        let path = fnamemodify(path, ':h')
    endwhile
    return ''
endfunc "}}}

func! s:CreateTagDB(root) "{{{
    let dbrun = '~/.vim/bin/0db.sh'
    let inputdir = substitute(input("TagDB dir: ", a:root, "dir"), '\/$', '', '')
    let tagsdir = '/tmp/tags' . inputdir . '/.tags'
    if !isdirectory(tagsdir)
        call mkdir(tagsdir, 'p')
    endif
    echomsg "Build TagDB: " . inputdir
    exec '!' . dbrun . ' ' . tagsdir . ' ' . inputdir
    return tagsdir . '/db.vim'
endfunc "}}}

func! s:BuildTagDB(root) "{{{
    :silent! messages clear
    :silent! redraw
    echomsg "1: Build or load db"
    echomsg "2: Delete before load db" 
    echomsg "3: Only delete db"
    echohl Search
    let res = str2nr(input("Select OP: ", ' '), 10)
    echohl None
    if res == 1
       call s:LoadTagDB(1, a:root)
    elseif res == 2
       call s:LoadTagDB(2, a:root)
    elseif res == 3
       call s:LoadTagDB(0, a:root)
    else
        return
    endif
endfunc "}}}

func! s:ShowAndLoadTagDB(root) "{{{
    if !vimshell#util#has_vimproc()
        echomsg "Need vimproc plugin supported!"
        return
    endif

    let tagdir = $tags
    if len(tagdir) == 0
        echomsg 'You must add envirenment tags, export tags=your_fix_tagdirs in ~/.profile file'
        " echomsg 'set env tags dir, you can add export tags=your_tag_dir into ~/.profile'
        " echomsg ' 1. 创建一个专门存放不同工程总Tag的目录 '
        " echomsg '    eg. mkdir -p /home/lidong/Workspace/tags '
        " echomsg ' 2. 设置系统环境变量tags指向总Tag的目录'
        " echomsg '    eg. export tags=/home/lidong/Workspace/tags (可以写到~/.profile) '
        " echomsg ' 3. 增加需要创建Tag的不同工程的目录 '
        " echomsg '    eg. mkdir -p /home/lidong/Workspace/tags/myproject1 '
        " echomsg ' 4. 在工程目录中创建db.sh, 指定工程源码路径即可'
        " echomsg '    db.sh内容可参考~/.vim/bin/db.sh '
        " echomsg ' 5. 在工程目录里, 执行./db.sh生成需要的tags, filenametags, cscope'
        " echomsg '    eg. cd /home/lidong/Workspace/tags/myproject1; ./db.sh '
        return
    endif

    let subdirs = [ ]
    let i = 0
    :silent! messages clear
    :silent! redraw

    " 0. 标准 c/c++ tags
    if isdirectory($HOME . '/.vim/tags')
        echomsg ' ' . i . ' ' . 'C/C++ tags'
        call add(subdirs, $HOME . '/.vim/tags')
    endif

    " 1. tags环境变量中的db (掉电不丢失)
    let dirs = vimproc#readdir(tagdir)
    for subdir in dirs
        let subdir = substitute(subdir, '\/$', '', '')
        let dbfile = subdir . '/db.vim'
        if filereadable(dbfile)
            let i = i + 1
            echomsg ' ' . i . ' ' . subdir
            call add(subdirs, subdir)
        endif
    endfor

    " 2. 临时目录下的tags
    if isdirectory('/tmp/tags')
        let dirs = split(system("dirname `find /tmp/tags/ -name .tags -type d`"), '\n')
        for subdir in dirs
            let i = i + 1
            echomsg ' ' . i . ' ' . substitute(subdir, '/tmp/tags', '', '')
            call add(subdirs, subdir . '/.tags')
        endfor
    endif

    " 3. 清空原全局tags
    set tags=
    :cs kill -1
    :cs reset
    let g:LookupFile_TagExpr=string('filenametags')
    let tlufiles=''

    " 4. 选择并设置tags
    echohl Search
    let tmpstr = input("Select TagDB(,): ", ' ')
    echohl None
    let nums = split(tmpstr, ',')
    for strn in nums 
        let n = str2nr(strn, 10)
        if n == 0
            exec 'set tags+=' . subdirs[0] . '/libc.tags'
            exec 'set tags+=' . subdirs[0] . '/cpp.tags'
            continue
        endif
        if n > 0 && n <= i
            let filenametags = subdirs[n] . '/filenametags'
            if filereadable(filenametags)
                let tlufiles = tlufiles . ' ' . filenametags
            endif

            let cscopeout = subdirs[n] . '/cscope.out'
            if filereadable(cscopeout)
                exec 'cs add ' . cscopeout . ' ' . subdirs[n]
            endif

            let cctreeout = subdirs[n] . '/cctree.out'
            if filereadable(cctreeout)
                exec  'silent! CCTreeLoadXRefDBFromDisk ' . cctreeout 
            endif

            let tagfile = subdirs[n] . '/tags'
            if filereadable(tagfile)
                exec 'set tags+=' . tagfile
            endif
        endif
    endfor
    let g:LookupFile_TagExpr=string(tlufiles)
endfunc "}}}

func! MyTags(mode) "{{{
    exec 'lchdir %:p:h'
    let root = getcwd()
    echomsg "Use select: "
    echomsg "   1 : Load databases, multiple dbs delimited by ','"
    echomsg "   2 : Build or load database in current dir."
    echohl Search
    let sel = str2nr(input("Select : ", ' '), 10)
    echohl None
    if sel == 1
        call s:ShowAndLoadTagDB(root)
    elseif sel == 2
        call s:BuildTagDB(root)
    else
        return 
    endif
endfunc "}}}

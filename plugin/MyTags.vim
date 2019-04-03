func! s:TmpLoadTagDB(force, root) "{{{
    let flg = str2nr(a:force, 10) 
    if flg == 1
        let dbfile = s:FindTagDB(a:root)
    else
        let dbfile = s:DeleteTagDB(a:root) 
    endif
    if flg == 0
        return
    endif
    let tagdirs = s:CreateTagDB(a:root)
    call s:Loading(tagdirs)
endfunc "}}}

func! s:FindTagDB(root) "{{{
    let path = a:root
    while 1 < len(path)
        let dbfile = '/tmp/tags' . path . '/.tags/tags'
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
    let inputdir = substitute(input("source dir:", a:root, "dir"), '\/$', '', '')
    let tagsdir = '/tmp/tags' . inputdir . '/.tags'
    if !isdirectory(tagsdir)
        call mkdir(tagsdir, 'p')
    endif
    :silent! messages clear
    :silent! redraw
    echomsg "build db: " . inputdir
    exec '!' . dbrun . ' ' . tagsdir . ' ' . inputdir
    return [tagsdir]
endfunc "}}}

func! s:BuildTagDB(root) "{{{
    :silent! messages clear
    :silent! redraw
    let res = str2nr(input("Select(1.build 2.rebuild 3.delete): ", ''), 10)
    if res == 1
        " build or load
        call s:TmpLoadTagDB(1, a:root)
    elseif res == 2
        " delete and load
        call s:TmpLoadTagDB(2, a:root)
    elseif res == 3
        " delete
        call s:TmpLoadTagDB(0, a:root)
    else
        return
    endif
endfunc "}}}

func! s:Loading(tagdirs) "{{{
    " 清空原全局tags
    set tags=
    :cs kill -1
    :cs reset
    let g:LookupFile_TagExpr=string('filenametags')

    let tlufiles=''
    let tIncfiles=[]
    for item in a:tagdirs
        let filenametags = item . '/filenametags'
        if filereadable(filenametags)
            let tlufiles = tlufiles . ' ' . filenametags
        endif

        let include_dirs = item . '/include_dirs.txt'
        if filereadable(include_dirs)
            for incdir in split(system("cat ". include_dirs), '\n')
                call add(tIncfiles, incdir)
            endfor
        endif

        let cscopeout = item . '/cscope.out'
        if filereadable(cscopeout)
            exec 'cs add ' . cscopeout . ' ' . item
        endif

        let cctreeout = item . '/cctree.out'
        if filereadable(cctreeout)
            exec  'silent! CCTreeLoadXRefDBFromDisk ' . cctreeout 
        endif

        let ctags = item . '/libc.tags'
        if filereadable(ctags)
            exec 'set tags+=' . ctags
        endif

        let cpptags = item . '/cpp.tags'
        if filereadable(cpptags)
            exec 'set tags+=' . cpptags
        endif

        let tagfile = item . '/tags'
        if filereadable(tagfile)
            exec 'set tags+=' . tagfile
        endif
    endfor
    let g:LookupFile_TagExpr=string(tlufiles)
    let g:syntastic_c_include_dirs = tIncfiles
    let g:syntastic_cpp_include_dirs = tIncfiles

    unlet tlufiles
    unlet tIncfiles
endfunc "}}}

func! s:LoadTagDB(root, tagdir) "{{{
    if !vimshell#util#has_vimproc()
        echomsg "Need vimproc plugin supported!"
        return
    endif

    if len(a:tagdir) == 0
        echomsg 'You must add envirenment tags, export tags=your_fix_tagdirs in ~/.profile file'
        return
    endif

    let subdirs = [ ]
    let tagdirs = [ ]
    let i = 0
    :silent! messages clear
    :silent! redraw

    " 1. 标准 c/c++ tags
    if isdirectory($HOME . '/.vim/tags')
        echomsg ' ' . i . ' ' . 'C/C++ tags'
        call add(subdirs, $HOME . '/.vim/tags')
    endif

    " 2. tags环境变量中的db (掉电不丢失)
    let dirs = vimproc#readdir(a:tagdir)
    for subdir in dirs
        let subdir = substitute(subdir, '\/$', '', '')
        let dbfile = subdir . '/tags'
        if filereadable(dbfile)
            let i = i + 1
            echomsg ' ' . i . ' ' . subdir
            call add(subdirs, subdir)
        endif
    endfor

    " 3. 临时目录下的tags
    if isdirectory('/tmp/tags')
        let s:dirs = split(system("dirname `find /tmp/tags/ -name .tags -type d`"), '\n')
        for subdir in s:dirs
            let i = i + 1
            echomsg ' ' . i . ' ' . substitute(subdir, '/tmp/tags', '', '')
            call add(subdirs, subdir . '/.tags')
        endfor
    endif

    " 4. 选择并设置tags
    let tmpstr = input("Select(,): ", '')
    let nums = split(tmpstr, ',')
    for strn in nums 
        let n = str2nr(strn, 10)
        if n == 0
            call add(tagdirs, subdirs[0])
            continue
        endif
        if n > 0 && n <= i
            call add(tagdirs, subdirs[n])
        endif
    endfor

    " 5. 加载
    call s:Loading(tagdirs)

    unlet tagdirs
    unlet subdirs
endfunc "}}}

func! s:UpdateAndLoadTagDB(root, tagdir) "{{{
    if len(a:tagdir) == 0
        echomsg 'You must add envirenment tags, export tags=your_fix_tagdirs in ~/.profile file'
        return
    endif
    let flg = 0
    let tmpdir = a:root
    while len(tmpdir) > 12 
        let gitdir = tmpdir . '/.git'
        let svndir = tmpdir . '/.svn'
        if isdirectory(gitdir) || isdirectory(svndir)
            let flg = 1
            break
        endif
        let pathpos = strridx(tmpdir, '/')
        let tmpdir = strpart(tmpdir, 0, pathpos)
    endwhile
    if flg == 1 
        let tag_dir = a:tagdir . "/" . fnamemodify(tmpdir, ":t")
        let prorun = 'cd ' . tag_dir . '; ./db.sh'
        if filereadable(tag_dir . '/db.sh')
            :silent! messages clear
            :redraw
            echomsg " Update ..."
            call system(prorun)
            call s:Loading([tag_dir])
            echomsg " Done..."
        endif 
    endif
endfunc "}}}

func! MyTags(mode) "{{{
    exec 'lchdir %:p:h'
    let root = getcwd()
    let sel = str2nr(input("Select(1.load 2.create):", ''), 10)

    let tagdir = $tags
    if len(tagdir) == 0
        if isdirectory('/projects/tags')
            let tagdir = '/projects/tags'
        endif
    endif

    if sel == 1
        call s:LoadTagDB(root, tagdir)
    elseif sel == 2
        call s:BuildTagDB(root)
    elseif sel == 3
        call s:UpdateAndLoadTagDB(root, tagdir)
    else
        return 
    endif
endfunc "}}}

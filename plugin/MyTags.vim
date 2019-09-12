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
    let dbrun = '$VIM_HOME/bin/0db.sh'
    let inputdir = substitute(input("source dir:", a:root, "dir"), '\/$', '', '')
    let tagsdir = expand('$TMP_TAGS' . inputdir . '/.tags')
    if !isdirectory(tagsdir)
        call mkdir(tagsdir, 'p')
    endif
    exec "silent! messages clear"
    echomsg "build db: " . inputdir
    exec '!' . dbrun . ' -y -s ' . inputdir . ' -t ' . tagsdir
    return [tagsdir]
endfunc "}}}

func! s:BuildTagDB(root) "{{{
    exec "silent! messages clear"
    exec "silent! redraw"
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
    exec "cs kill -1"
    exec "cs reset"
    let g:LookupFile_TagExpr=string('filenametags')

    let tlufiles=''
    let tIncfiles=[]
    for item in a:tagdirs
        let filenametags = item . '/filenametags'
        if filereadable(filenametags)
            let tlufiles = tlufiles . ' ' . filenametags
        endif

        let header_dirs = item . '/header_dirs.txt'
        if filereadable(header_dirs)
            for incdir in split(system("cat ". header_dirs), '\n')
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
    let g:syntastic_c_header_dirs = tIncfiles
    let g:syntastic_cpp_header_dirs = tIncfiles

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
    exec "silent! messages clear"
    exec "silent! redraw"

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
    if isdirectory($TMP_TAGS)
        let s:dirs = split(system("dirname `find " . $TMP_TAGS . " -name .tags -type d`"), '\n')
        for subdir in s:dirs
            let i = i + 1
            echomsg ' ' . i . ' ' . substitute(subdir, $TMP_TAGS, '', '')
            call add(subdirs, subdir . '/.tags')
        endfor
    endif

    " 4. 选择并设置tags
    let tmpstr = input("Select(,): ", '')
    exec 'silent! messages clear'
    exec 'redraw'
    echomsg " Loaded!"
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
        let prorun = 'cd ' . tag_dir . '; ./update.sh'
        if filereadable(tag_dir . '/db.sh')
            exec 'silent! messages clear'
            exec 'redraw'
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

    let tagdir = $TAG_HOME
    if len(tagdir) == 0
        if isdirectory('/projects/tags')
            let tagdir = '/projects/tags'
        else
            echomsg "not set TAG_HOME env"
            return
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

command! -bang -nargs=? -complete=dir MyUpdateTags call s:_MyUpdateTags(<q-args>)
func! s:_MyUpdateTags(tagdir) "{{{
    if !vimshell#util#has_vimproc()
        echomsg "Need vimproc plugin supported!"
        return
    endif

    if len(a:tagdir) == 0
        echomsg "Not set TAG_HOME!!!"
        return
    endif

    let upscripts = [ ]
    let i = 0
    :silent! messages clear

    let dirs = vimproc#readdir(a:tagdir)
    for subdir in dirs
        let subdir = substitute(subdir, '\/$', '', '')
        let upfile = subdir . '/update.sh'
        if filereadable(upfile)
            let i = i + 1
            echomsg ' ' . i . ' ' . subdir
            call add(upscripts, upfile)
        endif
    endfor

    if len(upscripts) == 0
        echomsg "Not found update.sh in " . a:tagdir "/subdir !!!"
        return
    endif

    let tmpstr = input("Select(,): ", '')
    echomsg ''
    let nums = split(tmpstr, ',')
    for strn in nums
        let t = str2nr(strn, 10) - 1
        call system(upscripts[t] . ' >/dev/null 2>&1 &')
    endfor

endfunc "}}}

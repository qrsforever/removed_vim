"========Python
 
command! -nargs=* -complete=file MyPythonRun call s:Python_Run(<f-args>)

function s:Python_Run()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg     = mp
    let &errorformat = ef
endfunction

command! -nargs=* MyToggleHtmlPhp call s:ToggleHtmlPhp()

function s:ToggleHtmlPhp()
    if &filetype == 'html'
        echomsg "Current filetype set PHP"
        set ft=php
    elseif &filetype == 'php'
        echomsg "Current filetype set HTML"
        set ft=html
    endif
endfunction

"========Scroll

command! -nargs=* MyScroll call s:MyScrollBinder()

function s:MyScrollBinder() 
    echomsg " Ver(1) Hor(2) Cancel(0) "
    let select = str2nr(input("Select: ", " " ), 10)
    if select == 1
        set scrollbind
        set scrollopt=ver
    elseif select == 2
        set scrollbind
        set scrollopt=hor
    else
        set noscrollbind
    endif
endfunction

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

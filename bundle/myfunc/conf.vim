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


command! -nargs=* MyTagL0 call s:LoadTagDB(0)
command! -nargs=* MyTagL1 call s:LoadTagDB(1)

func! s:LoadTagDB(force) 
    let root = getcwd()
    let flg = str2nr(a:force, 10) 
    let dbfile = s:FindTagDB(root)
    if flg == 1 || empty(dbfile)
        let dbfile = s:CreateTagDB(root)
    endif
    exec 'source ' . dbfile
    exec "redraw"
    echomsg "Use TagDB: " . dbfile
endfunc

func! s:FindTagDB(root) 
    let path = a:root
    while 1 < len(path)
        let dbfile = path . '/.tags/db.vim'
        if filereadable(dbfile)
            return dbfile
        endif
        let path = fnamemodify(path, ':h')
    endwhile
    return ''
endfunction

func! s:CreateTagDB(root) 
    let dbrun = '~/.vim/bin/db.sh'
    let inputdir = substitute(input("TagDB dir: ", a:root, "dir"), '\/$', '', '')
    let tagsdir = inputdir . '/.tags'
    if !isdirectory(tagsdir)
        call mkdir(tagsdir, 'p')
    endif
    echomsg "Build TagDB: " . inputdir
    exec '!' . dbrun . ' ' . tagsdir . ' ' . inputdir
    return tagsdir . '/db.vim'
endfunction

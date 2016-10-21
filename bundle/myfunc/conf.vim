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


command! -nargs=* MyTagDB call s:BuildAndUseDB()

func! s:BuildAndUseDB(...) 
    let path = getcwd()
    while 1 < len(path)
        let path = fnamemodify(path, ':h')
        let dbfile = path . '/.tags/db.vim'
        if filereadable(dbfile)
            break
        endif
    endwhile
    if filereadable(dbfile)
        echomsg "Use TagDB: " . dbfile
        exec 'source ' . dbfile
        exec "redraw"
        return
    endif
    let dbrun = '~/.vim/bin/db.sh'
    let inputdir = substitute(input("TagDB dir: ", getcwd(), "dir"), '\/$', '', '')
    let tagsdir = inputdir . '/.tags'
    if !isdirectory(tagsdir)
        call mkdir(tagsdir, 'p')
    endif
    echomsg "Build TagDB: " . inputdir
    exec '!' . dbrun . ' ' . tagsdir . ' ' . inputdir
    echomsg "UseTagDB: " . tagsdir . '/db.vim'
    exec 'source ' . tagsdir . '/db.vim'
    exec "redraw"
endfunc

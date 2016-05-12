command! -nargs=* -complete=file PythonRun call s:Python_Run(<f-args>)

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

command! -nargs=* ToggleHtmlPhp call s:ToggleHtmlPhp()

function s:ToggleHtmlPhp()
    if &filetype == 'html'
        echomsg "Current filetype set PHP"
        set ft=php
    elseif &filetype == 'php'
        echomsg "Current filetype set HTML"
        set ft=html
    endif
endfunction

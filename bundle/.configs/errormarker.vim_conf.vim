nmap <silent> <unique> `<space> :ErrorAtCursor<CR>
" hi ErrorMsg cterm=bold ctermbg=DarkRed gui=bold guibg=DarkRed
" hi WarningMsg cterm=bold ctermbg=LightRed gui=bold guibg=LightRed
let errormarker_errortext = "EE"
let errormarker_warningtext = "WW"
let errormarker_warningtypes = "wW"
let errormarker_errorgroup = "ErrorMsg"
let errormarker_warninggroup = "Todo"
"let &errorformat="%f:%l:%c: %t %n: %m," . &errorformat
"let &errorformat="%f:%l:%c: %t%*[^:]:%m," . &errorformat
"f:file l:line c:column t:warningtypes m:message
let errormarker_erroricon = "/usr/share/icons/gnome/16x16/status/dialog-error.png"   "gvim
let errormarker_warningicon = "/usr/share/icons/gnome/16x16/status/dialog-warning.png" "gvim

function QfSearchError(pattern)
    let h = winheight(0) / 2
    execute "topleft copen" . h
    execute "redraw"
    let results = []
    execute "silent! g/" . a:pattern . "/call add(results, getline('.'))"
    if !empty(results)
        execute "normal G"
        execute "normal zb"
    else 
        echomsg "no error!"
        execute "cclose"
    endif
endfunction

"CTRL-W <Enter>  垂直打开

augroup QFix
    au BufReadPost quickfix silent! nmap <buffer> q :cclose<CR>
    " au QuickFixCmdPre make execute "silent! lchdir %:p:h"
    " au QuickfixCmdPost make call QfSearchError("error:")
augroup END

au FileType c,cpp setlocal makeprg=make\ -j4

command! -nargs=* -complete=file MyMake call s:DoSelectMake(<f-args>)

let s:MakefileDirsFile = expand('$HOME/.MakefileDirsFile')
let s:MaxFileCount = 3

func! s:DoSelectMake(...) "{{{
    if &filetype == 'python'
        exec "MyPythonRun"
        return 
    elseif &filetype == 'qf'
        exec 'cclose'
        return
    endif

    if ! filereadable(s:MakefileDirsFile)
        call writefile(["#Makefile director"], s:MakefileDirsFile)
    endif
    let makefileDirsList = readfile(s:MakefileDirsFile)
    let incount = 0
    let infiles = []
    for i in makefileDirsList
        if i != ''
            if !isdirectory(i)
                continue
            endif
            let makefile = i . '/Makefile'
            let antfile = i . '/build.xml'
            if filereadable(makefile) || filereadable(antfile)
                call add(infiles, i)
            endif
        endif
    endfor

    let outfiles = []
    let outcount = 0
    let i = 1
    for dir in infiles
        if i == 1
            echomsg " " . i ". " . dir . "  (*)"
        else 
            echomsg " " . i ". " . dir
        endif
        let i += 1
    endfor
    echomsg " " . i ". Input manually"

    let inputdir = ""
    let select = str2nr(input("Select Makefile in dirs: ", ''), 10)         

    if select ==0 || select > i 
        echomsg " "
        echomsg "Select error!"
        return 
    elseif select == i
        let inputdir = substitute(input("Input dir: ", getcwd(), "dir"), '\/$', '', '')
        let makefile = inputdir . '/Makefile'
        let antfile = inputdir . '/build.xml'
        if filereadable(makefile) || filereadable(antfile)
            let addflg = 1
            for dir in infiles
                if dir == inputdir
                    let addflg = 0
                endif
            endfor
            if addflg
                let outcount += 1
                call add(outfiles, inputdir)
            endif
            for dir in infiles
                call add(outfiles, dir)
                let outcount += 1
                if outcount > s:MaxFileCount
                    break
                endif
            endfor
            if addflg
                call writefile(outfiles, s:MakefileDirsFile)
            endif
        else 
            let inputdir = ""
        endif
    else 
        let select -= 1
        let inputdir = infiles[select]
        let i = 0
        let saveflg = 0
        for dir in infiles
            if dir == inputdir
                if i == 0
                    break
                endif
                let saveflg = 1
                call add(outfiles, dir)
            endif
            let i += 1
        endfor
        if saveflg == 1
            for dir in infiles
                if dir != inputdir
                    call add(outfiles, dir)
                endif
            endfor
            call writefile(outfiles, s:MakefileDirsFile)
        endif
    endif

    let makefile = inputdir . '/Makefile'
    let antfile = inputdir . '/build.xml'
    if inputdir != ""
        exec "cd " . inputdir
        if filereadable(makefile)
            setlocal makeprg=make\ -j4
            exec "make"
        elseif filereadable(antfile)
         silent exec "Ant clean"
         silent exec "Ant debug"
        else
            echomsg "No configure file found!"
        endif
        exec "silent! cd -"
    else 
        echomsg "Input is empty!"
        return 
    endif
endfunc"}}}

"========Python
command! -nargs=* -complete=file MyPythonRun call s:Python_Run(<f-args>)

function s:Python_Run()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python3\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

    execute 'cclose'
    silent make %
    let h = winheight(0) / 2
    execute "topleft copen" . h
    execute "normal G"
    execute "normal zb"
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


"{{{ MyMake
"CTRL-W <Enter>  垂直打开
let s:MakefileDirsFile = expand('$HOME/.MakefileDirsFile')
let s:MaxFileCount = 3
func! MyMake(mode)
    exec 'silent! cclose'
    if &filetype == 'python' || &filetype == 'sh'
        exec "MyAsyncRun"
        return 
    elseif &filetype == 'r'
        if a:mode == 'v'
            " call feedkeys("\<Plug>(RDSendSelection)")
            call SendSelectionToR("silent", "stay")
        elseif a:mode == 'n'
            " call feedkeys("\<Plug>(RDSendLine)")
            call SendLineToR("stay")
        endif
        return
    elseif &filetype == 'qf'
        return
    endif

    if ! filereadable(s:MakefileDirsFile)
        call writefile(["# Makefile director"], s:MakefileDirsFile)
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
            let pomfile = i . '/pom.xml'
            if filereadable(makefile) || filereadable(antfile) || filereadable(pomfile)
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
    let select = str2nr(input("Select Makefile in dirs: ", '1'), 10)         
    
    if select == 0 || select > i 
        return
    endif

    if select == i
        let flg = 0
        let inputdir = substitute(input("Input dir: ", getcwd(), "dir"), '\/$', '', '')
        while len(inputdir) > 12 
            let makefile = inputdir . '/Makefile'
            let antfile = inputdir . '/build.xml'
            let pomfile = inputdir . '/pom.xml'
            if filereadable(makefile) || filereadable(antfile) || filereadable(pomfile)
                let flg = 1
                break
            endif
            let pathpos = strridx(inputdir, '/')
            let inputdir = strpart(inputdir, 0, pathpos)
        endwhile
        if flg == 1
            call add(outfiles, inputdir)
            let outcount += 1
            for dir in infiles
                if dir != inputdir
                    call add(outfiles, dir)
                    let outcount += 1
                    if outcount > s:MaxFileCount
                        break
                    endif
                endif
            endfor
            call writefile(outfiles, s:MakefileDirsFile)
        else
            let inputdir = ''
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
    let pomfile = inputdir . '/pom.xml'
    if inputdir != ""
        if filereadable(makefile)
            silent exec "AsyncRun -post=MyBottomCopen make -f " . makefile
        elseif filereadable(antfile)
            silent exec "AsyncRun -post=MyBottomCopen ant -f " . antfile
        elseif filereadable(pomfile)
            silent exec "AsyncRun -post=MyBottomCopen mvn compile -f " . pomfile
        else
            echomsg "No configure file found!"
        endif
    else 
        echomsg " "
        echomsg "Input is empty!"
        return 
    endif
endfunc"}}}

"{{{ MyAsyncRun 
command! MyAsyncRun :call s:DoASyncRun()
func! s:DoASyncRun()
    " if !exists(':AsyncRun')
        " echomsg "No asyncrun plugin"
        " return
    " endif
    let ef = &errorformat
    if &filetype == 'python'
        setlocal errorformat+=\%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
        exec "AsyncRun -post=MyBelowCopen python3 %"
    elseif &filetype == 'sh'
        exec "AsyncRun -post=MyBelowCopen bash %"
    elseif &filetype == 'c'
        exec "AsyncRun -post=MyBelowCopen gcc % -o %<"
    elseif &filetype == 'cpp'
        exec "AsyncRun -post=MyBelowCopen g++ -O3 % -o %< -lpthread"
    endif
    let &errorformat = ef
endfunc
"}}}
 
"{{{ MyPythonRun
" command! MyPythonRun call s:Python_Run()
" function s:Python_Run()
"     let mp = &makeprg
"     let ef = &errorformat
"     let exeFile = expand("%:t")
"     setlocal makeprg=python3\ -u
"     setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"                 "\%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
"                 "\%C\ \ \ \ %.%#,
"                 "\%+Z%.%#Error\:\ %.%#,
"                 "\%A\ \ File\ \"%f\"\\\,\ line\ %l,
"                 "\%+C\ \ %.%#,
"                 "\%-C%p^,
"                 "\%Z%m,
"                 "\%-G%.%#
"     silent make %
"     " let list = getqflist()
"     " if len(list) > 0
"     "     execute "MyBottomCopen"
"     "     execute "normal G"
"     "     execute "normal zb"
"     " else
"     "     echomsg "SUCCESS!"
"     " endif
"     let &makeprg     = mp
"     let &errorformat = ef
" endfunction
" "}}}

" function QfSearchError(pattern) "{{{
"     let h = winheight(0) / 2
"     execute "topleft copen" . h
"     execute "redraw"
"     let results = []
"     execute "silent! g/" . a:pattern . "/call add(results, getline('.'))"
"     if !empty(results)
"         execute "normal G"
"         execute "normal zb"
"     else 
"         echomsg "no error!"
"         execute "cclose"
"     endif
" endfunction
" 
" augroup QFix
"     " au QuickFixCmdPre make execute "silent! lchdir %:p:h"
"     " au QuickfixCmdPost make call QfSearchError("error:")
" augroup END
"}}}


function!  DoAfterFinished() 
        " Not impl
endfunc

let g:asyncrun_exit = 'call DoAfterFinished()'

command! MyAsyncRun :call s:DoSyncRun()

func! s:DoSyncRun()
    if &filetype == 'python'
        exec "AsyncRun -post=MyBottomCopen python3 %"
    elseif &filetype == 'c'
        exec "AsyncRun -post=MyBottomCopen gcc % -o %<"
    elseif &filetype == 'cpp'
        exec "AsyncRun -post=MyBottomCopen g++ -O3 % -o %< -lpthread"
    endif
    " if &filetype == 'c' || &filetype == 'cpp'
        " exec "lchdir %:p:h"
        " let curdir = getcwd()
        " while len(curdir) > 12 
            " let children = vimproc#readdir(curdir)
            " for child in children
                " let child = substitute(child, '\/$', '', '')
                " if isdirectory(child)
                    " continue
                " endif

                " let filen = strpart(child, len(child) - 8)
                " exec "lchdir " . expand(curdir , ":p:h")
                " if 'Makefile' ==# filen
                    " " not impl
                    " exec "AsyncRun -post=MyBottomCopen make -f " . child
                    " return
                " endif
            " endfor
            " let pathpos = strridx(curdir, '/')
            " let curdir = strpart(curdir, 0, pathpos)
        " endwhile
    " endif
endfunc


function!  DoAfterFinished() 
        " Not impl
endfunc

let g:asyncrun_exit = 'call DoAfterFinished()'

command! MyAsyncMake :call s:DoSyncMake()

func! s:DoSyncMake()
    if &filetype == 'python'
        exec "AsyncRun -post=MyBottomCopen python " . expand("%:p")
        return
    endif
    if &filetype == 'c' || &filetype == 'cpp'
        exec "lchdir %:p:h"
        let curdir = getcwd()
        while len(curdir) > 12 
            let children = vimproc#readdir(curdir)
            for child in children
                let child = substitute(child, '\/$', '', '')
                if isdirectory(child)
                    continue
                endif

                let filen = strpart(child, len(child) - 8)
                if 'Makefile' ==# filen
                    " not impl
                    exec "AsyncRun -post=MyBottomCopen make -f " . child
                    return
                endif
            endfor
            let pathpos = strridx(curdir, '/')
            let curdir = strpart(curdir, 0, pathpos)
        endwhile
    endif
endfunc

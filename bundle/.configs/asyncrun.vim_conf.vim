"Set up {{{
function!  DoAfterFinished() 
        " Not impl
endfunc
let g:asyncrun_exit = 'call DoAfterFinished()'
"}}}
"
command! MyAsyncRun :call s:DoSyncRun()
func! s:DoSyncRun() "{{{
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

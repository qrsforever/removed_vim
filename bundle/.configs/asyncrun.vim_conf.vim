"Set up {{{
function!  DoAfterFinished() 
        " Not impl
endfunc
let g:asyncrun_exit = 'call DoAfterFinished()'
"}}}
"
command! MyAsyncRun :call s:DoSyncRun()
func! s:DoSyncRun() "{{{
    if &filetype == 'python'
        exec "AsyncRun -post=MyBottomCopen python3 %"
    elseif &filetype == 'sh'
        exec "AsyncRun -post=MyBottomCopen bash %"
    elseif &filetype == 'c'
        exec "AsyncRun -post=MyBottomCopen gcc % -o %<"
    elseif &filetype == 'cpp'
        exec "AsyncRun -post=MyBottomCopen g++ -O3 % -o %< -lpthread"
    endif
endfunc
"}}}

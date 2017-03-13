command! MyBufExplorer call s:DoBufExplorer()
function! s:DoBufExplorer()
    let s:buftype = getbufvar('%', '&filetype')
    let s:buffers = ['nerdtree', 'tagbar', 'qf', 'unite']
    for name in s:buffers
        if name ==# s:buftype
            echomsg "Can not use BufExplorer in " . name
            return
        endif
    endfor
    if empty(s:buftype)
        let s:bufname = bufname('%')
        if s:bufname ==# "[BufExplorer]"
            " silent execute "keepjumps silent b "
            silent execute "keepjumps silent bwipeout "
            return
        endif
    endif
    let ret = call('BufExplorer', a:000)
    return ret
endfunction

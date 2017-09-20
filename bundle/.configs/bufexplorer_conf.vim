" let g:bufExplorerSplitHorzSize = 30
command! MyBufExplorer call s:DoBufExplorer()
function! s:DoBufExplorer()
    let buftype = getbufvar('%', '&filetype')
    let ret = MyFun_is_special_buffer(buftype)
    if ret == 0
        execute "BufExplorer"
    else
        if buftype ==# 'bufexplorer'
            execute "normal q"
        endif
    endif
endfunction

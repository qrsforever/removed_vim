"vim8.0 999tab 问题 ---> 改为$tab, 作者已经有补丁尚没有合入master
"https://github.com/jlanzarotta/bufexplorer/pull/56

command! MyBufExplorer call s:DoBufExplorer()
function! s:DoBufExplorer()
    let buftype = getbufvar('%', '&filetype')
    let buffers = ['nerdtree', 'tagbar', 'qf', 'unite']
    for name in buffers
        if name ==# buftype
            echomsg "Can not use BufExplorer in " . name
            return
        endif
    endfor
    unlet buffers
    execute "ToggleBufExplorer"
    "if len(buftype) == 0
    "    let bufname = bufname('%')
    "    if bufname ==# "[BufExplorer]"
    "        silent execute "keepjumps silent b "
    "        " silent execute "keepjumps silent bwipeout "
    "        return
    "    endif
    "endif
    "let ret = call('BufExplorer', a:000)
    "return ret
endfunction

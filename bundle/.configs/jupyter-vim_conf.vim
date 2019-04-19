"{{{ Base
let g:jupyter_runflags = '-i'
let g:jupyter_auto_connect = 0
let g:jupyter_verbose = 0
let g:jupyter_mapkeys = 1
let g:jupyter_monitor_console = 1
let g:jupyter_vsplit = 1
let g:jupyter_mapkeys = 0

let g:priv_window_mode = 1


function! s:DoCommandDelayUpdate(cmd)
    exec a:cmd
    " 等待notebook kernel return data
    call system("sleep 0.5")
    if g:priv_window_mode == 1
        exec 'silent! JupyterUpdateVShell'
    else
        exec 'silent! JupyterUpdateShell'
    endif
endfunction

" 关闭终端窗口
function! s:DoToggleWindow(flag)
    if bufexists('__jupyter_term__')
        exec 'silent! bwipeout __jupyter_term__'
    else
        if a:flag == 1
            exec 'JupyterUpdateVShell'
            let g:priv_window_mode = 1
        else
            exec 'JupyterUpdateShell'
            let g:priv_window_mode = 0
        endif
    endif
endfunction

function! s:DoUpdateWindow(flag)
    if bufexists('__jupyter_term__')
        if a:flag == 1
            exec 'bwipeout __jupyter_term__'
        else
            let bufid = bufnr('__jupyter_term__')
            if bufid != -1
                exec 'bunload! ' . bufid
            endif
        endif
        if g:priv_window_mode == 1
            exec 'silent! JupyterUpdateVShell'
        else
            exec 'silent! JupyterUpdateShell'
        endif
    endif
endfunction

command Jupyter JupyterConnect
"}}}

nnoremap <unique> <silent> <leader>jr :call <SID>DoCommandDelayUpdate("JupyterRunFile")<CR>
nnoremap <unique> <silent> <leader>ji :call <SID>DoCommandDelayUpdate("PythonImportThisFile")<CR>
nnoremap <unique> <silent> <leader>jd :call <SID>DoCommandDelayUpdate("JupyterCd %:p:h")<CR>
nnoremap <unique> <silent> <leader>je :call <SID>DoCommandDelayUpdate("JupyterSendCell")<CR>
nnoremap <unique> <silent> <leader>jj :call <SID>DoCommandDelayUpdate("JupyterSendCount")<CR>

nmap     <unique> <silent> <leader>jl <Plug>JupyterRunTextObj
vmap     <unique> <silent> <leader>jl <Plug>JupyterRunVisual
nnoremap <unique> <silent> <leader>jb :PythonSetBreak<CR>
nnoremap <unique> <silent> <leader>jc :call <SID>DoUpdateWindow(1)<CR>
nnoremap <unique> <silent> <leader>ju :call <SID>DoUpdateWindow(0)<CR>
nnoremap <unique> <silent> <leader>jw :call <SID>DoToggleWindow(1)<CR>
nnoremap <unique> <silent> <leader>jW :call <SID>DoToggleWindow(0)<CR>

" nnoremap <silent> <leader>ju :JupyterUpdateShell<CR>
" nnoremap <silent> <leader>jU :JupyterUpdateVShell<CR>

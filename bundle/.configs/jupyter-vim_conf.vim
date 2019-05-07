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
    " not working
    " let bufid = winbufnr('__jupyter_term__')
    " if bufid != -1
        " exec bufid . 'windo norm zz'
    " endif
endfunction

" 关闭终端窗口
function! s:DoToggleWindow(flag)
    if bufexists('__jupyter_term__')
        exec 'silent! bwipeout __jupyter_term__'
        if a:flag == 2
            return
        endif
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
        if a:flag != 2
            if a:flag == 1
                exec 'bwipeout __jupyter_term__'
            else
                let bufid = bufnr('__jupyter_term__')
                if bufid != -1
                    exec 'bunload! ' . bufid
                endif
            endif
        endif
        if g:priv_window_mode == 1
            exec 'silent! JupyterUpdateVShell'
        else
            exec 'silent! JupyterUpdateShell'
        endif
    endif
endfunction

function! s:DoCreateAndConnect()
    exec 'silent! !~/.vim/bin/0jupyter-qtconsole.sh'
    echomsg "wait start..."
    call system("sleep 4.5")
    exec 'redraw!'
    exec 'JupyterConnect'
endfunction

command Jupyter      call <SID>DoCreateAndConnect()
"}}}

nnoremap <unique> <silent> <leader>ji :call <SID>DoCommandDelayUpdate("PythonImportThisFile")<CR>
nnoremap <unique> <silent> <leader>jj :call <SID>DoCommandDelayUpdate("JupyterSendCount")<CR>
nnoremap <unique> <silent> <leader>jb :PythonSetBreak<CR>
" clear window, 窗口数据太多, 需要清理(主动)
nnoremap <unique> <silent> <leader>jc :call <SID>DoUpdateWindow(1)<CR>
" update window, 有时数据量, 回调数据慢, 需要更新(被动)
nnoremap <unique> <silent> <leader>ju :call <SID>DoUpdateWindow(0)<CR>
nnoremap <unique> <silent> <leader>jU :call <SID>DoUpdateWindow(2)<CR>

" 将映射集中到左右字符('q,w,e,r,s,d')
nnoremap <unique> <silent> <leader>jr :call <SID>DoCommandDelayUpdate("JupyterRunFile")<CR>
nnoremap <unique> <silent> <leader>jd :call <SID>DoCommandDelayUpdate("JupyterCd %:p:h")<CR>
nnoremap <unique> <silent> <leader>je :call <SID>DoCommandDelayUpdate("JupyterSendCell")<CR>
nmap     <unique> <silent> <leader>js <Plug>JupyterRunTextObj
vmap     <unique> <silent> <leader>js <Plug>JupyterRunVisual
nnoremap <unique> <silent> <leader>jq :call <SID>DoToggleWindow(2)<CR>
nnoremap <unique> <silent> <leader>jw :call <SID>DoToggleWindow(1)<CR>
nnoremap <unique> <silent> <leader>jW :call <SID>DoToggleWindow(0)<CR>

augroup JupyterTerm
    au BufEnter __jupyter_term__ silent! nmap <silent> <buffer> q :silent! q<CR>
    au BufEnter __jupyter_term__ setlocal wrap
augroup END

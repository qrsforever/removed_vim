"{{{ Base
let g:jupyter_runflags = '-i'
let g:jupyter_auto_connect = 0
let g:jupyter_verbose = 0
let g:jupyter_mapkeys = 1
let g:jupyter_monitor_console = 1
let g:jupyter_vsplit = 1
let g:jupyter_mapkeys = 0

" 关闭终端窗口
" bufexists({expr})
function! s:DoToggleWindow(flag)
    if bufexists('__jupyter_term__')
        exec 'silent! bwipeout __jupyter_term__'
    else
        if a:flag == 1
            exec 'JupyterUpdateVShell'
        else
            exec 'JupyterUpdateShell'
        endif
    endif
endfunction
command Jupyter JupyterConnect
"}}}

nnoremap <unique> <silent> <leader>jr :JupyterRunFile<CR>
nnoremap <unique> <silent> <leader>jd :JupyterCd %:p:h<CR>
nmap     <unique> <silent> <leader>je <Plug>JupyterRunTextObj
vmap     <unique> <silent> <leader>je <Plug>JupyterRunVisual
nnoremap <unique> <silent> <leader>ji :PythonImportThisFile<CR>
nnoremap <unique> <silent> <leader>jb :PythonSetBreak<CR>
nnoremap <unique> <silent> <leader>jc :JupyterSendCell<CR>
nnoremap <unique> <silent> <leader>jj :JupyterSendCount<CR>
nnoremap <unique> <silent> <leader>jw :call <SID>DoToggleWindow(1)<CR>
nnoremap <unique> <silent> <leader>jW :call <SID>DoToggleWindow(0)<CR>

" nnoremap <silent> <leader>ju :JupyterUpdateShell<CR>
" nnoremap <silent> <leader>jU :JupyterUpdateVShell<CR>

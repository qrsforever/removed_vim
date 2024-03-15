"{{{Setup

let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

nmap <silent> ]cn :GitGutterNextHunk<CR>
nmap <silent> ]cp :GitGutterPrevHunk<CR>
nmap <silent> ]cu :GitGutterUndoHunk<CR>
nmap <silent> ]cf :GitGutterFolder<CR>
nmap <silent> ]cg :GitGutterSignsToggle<CR>

function! s:QuickfixCurrrentFile()
    exec 'lchdir %:p:h'
    exec 'GitGutterQuickFixCurrentFile'
    exec 'copen'
endfunction

nmap <silent> ]ce :call <SID>QuickfixCurrrentFile()<CR>

function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    if a == 0 && m == 0 && r == 0
        return ''
    endif
    return printf('+%d ~%d -%d', a, m, r)
endfunction

"}}}

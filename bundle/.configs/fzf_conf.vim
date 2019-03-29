""" Setup{{{

" 与fuzzyfinder 统一:
"  <c-s> :水平分割选中项
"  <c-v> :垂直分割选中项
"  <c-t>:tab打开选中项
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }

" 窗口显示位置: down / up / left / right
let g:fzf_layout = { 'down': '50%' }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

""" }}}

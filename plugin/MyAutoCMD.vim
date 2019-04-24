
" au FileType text,markdown  setlocal wrap|setlocal textwidth=86

autocmd FileType c,cpp setlocal makeprg=make\ -j4
autocmd FileType python setlocal makeprg=python3\ -u

augroup QFix
    au BufReadPost quickfix silent! nmap <silent> <buffer> q :silent! q<CR>
augroup END

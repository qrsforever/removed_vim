let g:tagbar_autofocus = 1
let g:tagbar_width = 36
let g:tagbar_autoshowtag = 1
let g:tagbar_autoclose = 0
let g:tagbar_left = 0
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_expand = 0
let g:tagbar_singleclick = 0
let g:tagbar_iconchars = ['▶', '▼']
" let g:tagbar_updateonsave_maxlines = 10000
"highlight TagbarScope guifg=Green ctermfg=Green

autocmd BufNewFile,BufReadPost *.aidl let b:tagbar_ignore = 1
"autocmd BufLeave *.cpp,*.c,*.h resize 
 

" 支持markdown
" ln -s ~/.vim/configure/ctags ~/.ctags
let g:tagbar_type_markdown = {
            \ 'ctagstype' : 'markdown',
            \ 'kinds' : [
                \ 'h:headings',
                \ 'l:links',
                \ 'i:images'
            \ ],
    \ "sort" : 0
    \ }


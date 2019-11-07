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
let g:tagbar_ctags_bin = "ctags"

" let g:tagbar_updateonsave_maxlines = 10000
"highlight TagbarScope guifg=Green ctermfg=Green

" autocmd BufNewFile,BufReadPost *.aidl let b:tagbar_ignore = 1
" autocmd BufLeave *.cpp,*.c,*.h resize 
"
" autoload/tagbar.vim: 366左右(BufEnter造成), 下面的代码会导致, Fuf启动buffer窗口后, 有异常
" 暂时没有很好的解决方案, 可以去掉BufEnter
" autocmd BufReadPost,BufEnter,CursorHold,FileType * call
"     \ s:AutoUpdate(fnamemodify(expand('<afile>'), ':p'), 0)

" 支持markdown
" ln -s ~/.vim/configure/ctags ~/.ctags
" let g:tagbar_type_markdown = {
"             \ 'ctagstype' : 'markdown',
"             \ 'kinds' : [
"                 \ 'h:headings',
"                 \ 'l:links',
"                 \ 'i:images'
"             \ ],
"     \ "sort" : 0
"     \ }
" 

" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '$VIM_HOME/configure/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" Note: This option must set it in .vimrc(_vimrc).
" NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#sources#buffer#disabled_pattern = '\.log\|\.log\.\|\.jax'
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*|\.log\|\.log\.\|.*quickrun.*\|.jax'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'xml' : "~/.vim/dict/android_xml.txt,~/.vim/dict/ant_xml.txt",
            \ 'text' : '~/.vim/dict/wordlist.txt'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" let g:neocomplete#fallback_mappings =
"            \ ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]

" Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()
" 

" <CR>: close popup and save indent."{{{
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
    "
    " 回车总是有问题, 暂时的处理方式
    " if pumvisible() 
    "     call neocomplete#close_popup()
    "     return "\<Space>"
    " else
    "     return "\<CR>"
    " endif
endfunction
"}}}

" <TAB>: completion."{{{
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ neocomplete#start_manual_complete()

function! s:check_back_space() abort 
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
"}}}
 
" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
" inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

let g:neocomplete#cursor_hold_i_time = 1000

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

let g:neocomplete#force_overwrite_completefunc=1 
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=python3complete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
"使用默认
"let g:neocomplete#sources#omni#input_patterns.java = '\k\.\k*'
let g:neocomplete#sources#omni#input_patterns.ruby = ''
" let g:neocomplete#sources#omni#input_patterns.python = ''

"let g:neocomplete#sources#omni#input_patterns.php =
"           \ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
"
" omnicppcomte插件已包含
" let g:neocomplete#sources#omni#input_patterns.c =
"            \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
" let g:neocomplete#sources#omni#input_patterns.cpp =
"             \ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
" let g:neocomplete#sources#omni#input_patterns.perl =
" \ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

" let g:neocomplete#sources#omni#input_patterns.php =   
            \ '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?' 

" support python2.7
" let g:neocomplete#force_omni_input_patterns.python = 
            " \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" 必须要有这个否则<c-x><c-o>不会自动弹出 
" let g:neocomplete#force_omni_input_patterns.java = '\k\.\k*'
" fix eclim does't work
let g:neocomplete#force_omni_input_patterns.java =                                                                                                     
    \ '\%(\h\w*\|)\)\.\w*'

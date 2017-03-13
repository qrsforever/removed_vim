" Enable history yank source
let g:unite_source_history_yank_enable = 1
let g:unite_enable_split_vertically = 0

let g:unite_source_file_rec_max_cache_files = 0
let g:unite_source_rec_max_cache_files = 0
let g:unite_source_rec_min_cache_files = 120
let g:unite_source_buffer_time_format = "(%Y-%m-%d %H:%M:%S) "
let g:unite_force_overwrite_statusline = 0
" let g:unite_ignore_source_files = []
" let g:unite_data_directory = "~/.cache/unite"
" let g:unite_source_bookmark_directory = '~/.cache/unite/bookmark'
let g:unite_enable_auto_select = 1
let g:unite_source_file_async_command = "ls -la"
let g:unite_source_grep_default_opts = '-iRHn'

" let s:filters = {
"     \   "name" : "my_converter",
"     \ }
" 
" function! s:filters.filter(candidates, context)
"     for candidate in a:candidates
"         let bufname = bufname(candidate.action__buffer_nr)
"         let filename = fnamemodify(bufname, ':p:t')
"         let path = fnamemodify(bufname, ':p:h')
"         " Customize output format.
"         let candidate.abbr = printf("[%s] %s", filename, path)
"     endfor
"     return a:candidates
" endfunction
" 
" call unite#define_filter(s:filters)
" unlet s:filters
" call unite#custom#source('buffer', 'converters', 'my_converter')

call unite#custom#profile(
    \ 'default', 
    \ 'context', 
    \ {
        \ 'winheight': 15,
        \ 'winwidth': 80,
        \ 'direction': 'dynamictop',
        \ 'verbose': 1,
        \ 'vertical': 0,
        \ 'horizontal': 1,
        \ 'prompt_direction': 'top',
        \ 'update-time': 250,
        \ 'auto-resize': 1,
        \ 'max-multi-lines': 6,
    \ })

call unite#custom#profile(
    \ 'files',
    \ 'filters',
    \ 'sorter_rank')

call unite#custom#source(
    \ 'file_rec, file_rec/async, file_rec/git',
    \ 'max_candidates', 
    \ 1000)

call unite#custom#source(
    \ 'buffer, file_rec, file_rec/git',
    \ 'matchers',
    \ ['converter_relative_word', 'matcher_fuzzy', 'matcher_project_ignore_files'])

call unite#custom#source(
    \ 'file_rec/async',
    \ 'matchers', 
    \ ['converter_relative_word', 'matcher_default'])

call unite#custom#source(
    \ 'file_rec, file_rec/async, file_rec/git, file_mru',
    \ 'converters',
    \ ['converter_file_directory'])

call unite#custom#source(
    \ 'file_rec, file_rec/async',
    \ 'required_pattern_length',
    \ 2)

call unite#custom#source(
    \ 'file_rec', 
    \ 'sorters', 
    \ 'sorter_length')


call unite#custom#source(
    \ 'file_rec, file_rec/async',
    \ 'ignore_globs',
    \ ['*.o', '*.obj', '*.class'])

call unite#custom#source(
    \ 'file_rec, file_rec/async',
    \ 'white_globs',
    \ ['R.class'])

" The prefix key.
nnoremap [unite]   <Nop>
nmap s [unite]

nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=sources -no-split -start-insert source<CR>
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> [unite]n :<C-u>Unite -buffer-name=mru -no-split -profile-name=default file_mru<CR>
nnoremap <silent> [unite]U :<C-u>UniteBookmarkAdd %<CR>
nnoremap <silent> [unite]u :<C-u>Unite -buffer-name=bookmark -no-empty bookmark<CR>
nnoremap <silent> [unite]v :<C-u>Unite -buffer-name=keymap mapping<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=files -no-split -no-empty -start-insert file_rec/async<CR>
nnoremap <silent> [unite]R :<C-u>Unite -buffer-name=files -no-split -no-empty -start-insert file_rec/git<CR>
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=find find:.<CR>

let g:unite_prompt = '» '

function! s:unite_my_settings()
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <C-c> <Plug>(unite_exit)
  imap <buffer> <C-c> <Plug>(unite_exit)
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <c-a> <Plug>(unite_choose_action)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
  imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
  imap <buffer> <TAB> <Plug>(unite_select_next_line)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)
  inoremap <silent><buffer><expr> <C-j> unite#do_action('split')
  nnoremap <silent><buffer><expr> <C-j> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-k> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-k> unite#do_action('vsplit')

  let unite = unite#get_current_unite()
  if unite.buffer_name =~# '^search'
      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
      nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif
endfunction
autocmd FileType unite call s:unite_my_settings()


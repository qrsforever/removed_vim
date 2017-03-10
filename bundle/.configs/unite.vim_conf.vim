" Start in insert mode
let g:unite_enable_start_insert = 1

" Enable short source name in window
" let g:unite_enable_short_source_names = 1

" Enable history yank source
let g:unite_source_history_yank_enable = 1
let g:unite_enable_split_vertically = 0

" Open in bottom right
let g:unite_split_rule = "botright"

" Shorten the default update date of 500ms
let g:unite_update_time = 500
let g:unite_source_file_rec_max_cache_files = 0
let g:unite_source_rec_max_cache_files = 0
let g:unite_source_rec_min_cache_files = 120
let g:unite_source_buffer_time_format = "(%Y-%m-%d %H:%M:%S) "
let g:unite_source_file_mru_time_format = "(%Y-%m-%d %H:%M:%S) "
let g:unite_source_directory_mru_time_format = "(%Y-%m-%d %H:%M:%S) "
let g:unite_force_overwrite_statusline = 1
let g:unite_ignore_source_files = []
let g:unite_data_directory = "~/.cache/unite"
let g:unite_source_bookmark_directory = ''
let g:unite_enable_auto_select = 1
let g:unite_source_file_async_command = "ls -la"
let g:unite_source_grep_default_opts = '-iRHn'

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

" The prefix key.
nnoremap [unite]   <Nop>
nmap s [unite]

nnoremap <silent> [unite]r :<C-u>Unite -no-split -no-empty -start-insert -buffer-name=files buffer file_rec/async:! <CR>
nnoremap <silent> [unite]o :<C-u>Unite -no-split -buffer-name=outline -vertical outline<CR>
nnoremap <silent> [unite]p :<C-u>Unite -no-split -buffer-name=sessions session<CR>
nnoremap <silent> [unite]a :<C-u>Unite -no-split -buffer-name=sources source<CR>
nnoremap <silent> [unite]s :<C-u>Unite -no-split -buffer-name=snippets snippet<CR>
nnoremap <silent> [unite]d :<C-u>Unite -buffer-name=change-cwd -default-action=lcd directory_mru<CR>
nnoremap <silent> [unite]g :<C-u>Unite -winwidth=150 grep:%::<CR>
nnoremap <silent> [unite]G :<C-u>Unite -buffer-name=search -auto-preview -no-quit -no-empty grep:.::<CR>
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]n :<C-u>Unite -buffer-name=mru file_mru<CR>
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=find find:.<CR>
nnoremap <silent> [unite]v :<C-u>Unite -buffer-name=keymap mapping<CR>
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=history history/command command<CR>
" nnoremap <silent> [unite]r :<C-u>Unite file_rec<CR>
" nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" nnoremap <silent> [unite]x :<C-u>Unite -no-split -buffer-name=buffers buffer file_mru<CR>
" nnoremap <silent> [unite]x :<C-u>Unite -no-split -buffer-name=register register<CR>
" nnoremap <silent> [unite]x :<C-u>UniteWithBufferDir -no-split -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
" nnoremap <silent> [unite]x :<C-u>Unite -buffer-name=commands command<CR>
" nnoremap <silent> [unite]x :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>
" nnoremap <silent> [unite]x :<C-u>Unite -buffer-name=search_file line<CR>
" nnoremap <silent> [unite]x :<C-u>Unite -buffer-name=files file_rec/async file/new<CR>

let g:unite_prompt = '» '

function! s:unite_my_settings()

  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <C-c> <Plug>(unite_exit)
  imap <buffer> <C-c> <Plug>(unite_exit)
  imap <buffer> <ESC> <Plug>(unite_exit)
  "imap <buffer> <c-j> <Plug>(unite_select_next_line)
  "imap <buffer><expr> j unite#smart_map('j', '')
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <c-j> <Plug>(unite_insert_leave)
  nmap <buffer> <c-j> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <c-k> <Plug>(unite_loop_cursor_up)
  imap <buffer> <c-a> <Plug>(unite_choose_action)
  imap <buffer> <Tab> <Plug>(unite_insert_leave)
  imap <buffer> jj <Plug>(unite_insert_leave)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
  imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)
  inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  "nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  "nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

  let unite = unite#get_current_unite()
  if unite.buffer_name =~# '^search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')

  " Using Ctrl-\ to trigger outline, so close it using the same keystroke
  if unite.buffer_name =~# '^outline'
    imap <buffer> <C-\> <Plug>(unite_exit)
  endif

  " Using Ctrl-/ to trigger line, close it using same keystroke
  if unite.buffer_name =~# '^search_file'
    imap <buffer> <C-_> <Plug>(unite_exit)
  endif
endfunction
autocmd FileType unite call s:unite_my_settings()

" Normal mode mappings.
" {lhs}		{rhs}
" --------	-----------------------------
" i		|<Plug>(unite_insert_enter)|
" I		|<Plug>(unite_insert_head)|
" a		In case when you selected a candidate,
" 		|<Plug>(unite_choose_action)|
" 		else |<Plug>(unite_append_enter)|
" A		|<Plug>(unite_append_end)|
" q		|<Plug>(unite_exit)|
" Q		|<Plug>(unite_all_exit)|
" <C-r>		|<Plug>(unite_restart)|
" <Space>		|<Plug>(unite_toggle_mark_current_candidate)|
" *		|<Plug>(unite_toggle_mark_all_candidates)|
" M		|<Plug>(unite_toggle_max_candidates)|
" <Tab>		|<Plug>(unite_choose_action)|
" <C-n>		|<Plug>(unite_rotate_next_source)|
" <C-p>		|<Plug>(unite_rotate_previous_source)|
" <C-g>		|<Plug>(unite_print_message_log)|
" <C-l>		|<Plug>(unite_redraw)|
" <C-h>		|<Plug>(unite_delete_backward_path)|
" gg		|<Plug>(unite_cursor_top)|
" G		|<Plug>(unite_cursor_bottom)|
" j		|<Plug>(unite_loop_cursor_down)|
" <Down>		|<Plug>(unite_loop_cursor_down)|
" k		|<Plug>(unite_loop_cursor_up)|
" <Up>		|<Plug>(unite_loop_cursor_up)|
" J		|<Plug>(unite_skip_cursor_down)|
" K		|<Plug>(unite_skip_cursor_up)|
" ?		|<Plug>(unite_quick_help)|
" N		|<Plug>(unite_new_candidate)|
" <CR>		In case when you selected a candidate, runs default action
" d		In case when you selected a candidate, runs delete action
" b		In case when you selected a candidate, runs bookmark action
" e		In case when you selected a candidate, runs narrow action
" t		In case when you selected a candidate, runs tabopen action
" yy		In case when you selected a candidate, runs yank action
" p		runs preview action
" x		In case when you selected a candidate, runs
" 		|<Plug>(unite_quick_match_default_action)|
" .		|<Plug>(unite_narrowing_dot)|
" 
" Insert mode mappings.
" {lhs}		{rhs}
" --------	-----------------------------
" <ESC>		|i_<Plug>(unite_insert_leave)|
" <Tab>		|i_<Plug>(unite_choose_action)|
" <C-n>		|i_<Plug>(unite_select_next_line)|
" <Down>		|i_<Plug>(unite_select_next_line)|
" <C-p>		|i_<Plug>(unite_select_previous_line)|
" <Up>		|i_<Plug>(unite_select_previous_line)|
" <C-f>		|i_<Plug>(unite_select_next_page)|
" <C-b>		|i_<Plug>(unite_select_previous_page)|
" <CR>		|i_<Plug>(unite_do_default_action)|
" <C-h>		|i_<Plug>(unite_delete_backward_char)|
" <BS>		|i_<Plug>(unite_delete_backward_char)|
" <C-u>		|i_<Plug>(unite_delete_backward_line)|
" <C-w>		|i_<Plug>(unite_delete_backward_word)|
" <C-a>		|i_<Plug>(unite_move_head)|
" <Home>		|i_<Plug>(unite_move_head)|
" <C-l>		|i_<Plug>(unite_redraw)|
" <C-g>		|i_<Plug>(unite_exit)|
" e		In case when you selected a candidate, runs narrow action
" d		In case when you selected a candidate, runs delete action
" t		In case when you selected a candidate, runs tabopen action
" <Space>		In case when you selected a candidate,
" 		|i_<Plug>(unite_toggle_mark_current_candidate)|
" x		In case when you selected a candidate,
" 		|i_<Plug>(unite_quick_match_default_action)|
" 
" Visual mode mappings.
" {lhs}		{rhs}
" --------	-----------------------------
" <Space>		|v_<Plug>(unite_toggle_mark_selected_candidates)|

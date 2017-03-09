"let g:unite_winheight = 20
"let g:unite_winwidth = 90
let g:unite_force_overwrite_statusline = 1

"Set the default options for grep.
let g:unite_source_grep_default_opts = '-iRHn'

"Set the max number of unite-source-grep candidates.
let g:unite_source_grep_max_candidates = 150

" The prefix key.
nnoremap [unite]   <Nop>
nmap s [unite]

nnoremap <silent> [unite]r :<C-u>Unite file_rec<CR>
nnoremap <silent> [unite]d :<C-u>Unite directory_mru<CR>
nnoremap <silent> [unite]s :<C-u>Unite source<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep<CR>
nnoremap <silent> [unite]f :<C-u>Unite find<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]c :<C-u>Unite command<CR>
nnoremap <silent> [unite]v :<C-u>Unite mapping<CR>

" Start insert.
" let g:unite_enable_start_insert = 1
"let g:unite_enable_short_source_names = 1

" To track long mru history.
"let g:unite_source_file_mru_long_limit = 3000
"let g:unite_source_directory_mru_long_limit = 3000

" Like ctrlp.vim settings.
"let g:unite_enable_start_insert = 1
"let g:unite_winheight = 10
"let g:unite_split_rule = 'botright'

" Prompt choices.
"let g:unite_prompt = '❫ '
"let g:unite_prompt = '» '

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    " Overwrite settings.
    nmap <buffer> <ESC>      <Plug>(unite_exit)
    imap <buffer> jj      <Plug>(unite_insert_leave)
    "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

    imap <buffer><expr> j unite#smart_map('j', '')
    imap <buffer> <TAB>   <Plug>(unite_select_next_line)
    imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
    imap <buffer> '     <Plug>(unite_quick_match_default_action)
    nmap <buffer> '     <Plug>(unite_quick_match_default_action)
    imap <buffer><expr> x
                \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
    nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
    nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
    nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    nnoremap <silent><buffer><expr> l
                \ unite#smart_map('l', unite#do_action('default'))

    let unite = unite#get_current_unite()
    if unite.buffer_name =~# '^search'
        nnoremap <silent><buffer><expr> r     unite#do_action('replace')
    else
        nnoremap <silent><buffer><expr> r     unite#do_action('rename')
    endif

    nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
    nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
                \ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
endfunction

"let g:unite_source_file_mru_limit = 200
"let g:unite_cursor_line_highlight = 'TabLineSel'
"let g:unite_abbr_highlight = 'TabLine'

" For optimize.
let g:unite_source_file_mru_filename_format = ''

if executable('jvgrep')
    " For jvgrep.
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts = '--exclude ''\.(git|svn|hg|bzr)'''
    let g:unite_source_grep_recursive_opt = '-R'
endif

" For ack.
if executable('ack-grep')
    " let g:unite_source_grep_command = 'ack-grep'
    " let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
    " let g:unite_source_grep_recursive_opt = ''
endif

inoremap <silent><expr> <C-z>
            \ unite#start_complete('register', { 'input': unite#get_cur_text() })



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

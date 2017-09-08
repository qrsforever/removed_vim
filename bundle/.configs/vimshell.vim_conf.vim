" let g:vimshell_prompt = $USER."% "
" let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":~")."$", "\\[]()?! ")." "'
let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":t")."$", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+$ '
"let g:vimshell_prompt_pattern = ''
"let g:vimshell_user_prompt = ''
"let g:vimshell_max_command_history = 500
let g:vimshell_vimshrc_path	= '~/.vim/vimshrc'
let g:vimshell_disable_escape_highlight = 1
"let g:vimshell_enable_smart_case = 1
"let g:vimshell_interactive_update_time = 500
 
let g:vimshell_force_overwrite_statusline = 0
let g:vimshell_split_command = 'split'
" let g:vimshell_popup_command = 'split'
" let g:vimshell_popup_height = 30
"
"" Initialize execute file list.
"let g:vimshell_execute_file_list = {}
"call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java','vim')
"let g:vimshell_execute_file_list['rb'] = 'ruby'
"let g:vimshell_execute_file_list['pl'] = 'perl'
"let g:vimshell_execute_file_list['py'] = 'python'
"
" let g:vimshell_no_default_keymappings = 1
"let g:vimshell_use_terminal_command = 'gnome-terminal -e'

" nmap <silent> \sv :VimShell -toggle -buffer-name=@<CR>
" nmap <silent> \ss :lchdir %:p:h<CR>:VimShellCurrentDir -toggle -buffer-name=@ -split-command=split<CR>
" nmap <silent> \st :VimShellTab -create -buffer-name=@<CR>
"
command! MyVimShellS :call s:DoVimShell('25split')
command! MyVimShellV :call s:DoVimShell('60vsplit')

func! s:DoVimShell(t)
    let buftype = getbufvar('%', '&filetype')
    let ret = MyFun_is_special_buffer(buftype)
    if ret == 0
        exec "VimShellCurrentDir -buffer-name=# -split-command=" . a:t
    else
        if buftype ==# 'vimshell'
            exec "normal q"
        endif
    endif
endf

" Normal mode default key mappings.
" {lhs}			{rhs}
" --------		-----------------------------
" <C-p>			<Plug>(vimshell_int_previous_prompt)
" <C-n>			<Plug>(vimshell_int_next_prompt)
" <CR>			<Plug>(vimshell_int_execute_line)
" <C-y>			<Plug>(vimshell_int_paste_prompt)
" <C-z>			<Plug>(vimshell_int_restart_command)
" <C-c>			<Plug>(vimshell_int_interrupt)
" q			    <Plug>(vimshell_int_exit)
" cc			<Plug>(vimshell_int_change_line)
" dd			<Plug>(vimshell_int_delete_line)
" I			    <Plug>(vimshell_int_insert_head)
" A			    <Plug>(vimshell_int_append_end)
" i			    <Plug>(vimshell_int_insert_enter)
" a			    <Plug>(vimshell_int_append_enter)
" <C-l>			<Plug>(vimshell_int_clear)

" Insert mode default key mappings.
" {lhs}			{rhs}
" --------		-----------------------------
" <C-h>			<Plug>(vimshell_int_delete_backward_char)
" <BS>			<Plug>(vimshell_int_delete_backward_char)
" <C-a>			<Plug>(vimshell_int_move_head)
" <C-u>			<Plug>(vimshell_int_delete_backward_line)
" <C-w>			<Plug>(vimshell_int_delete_backward_word)
" <C-k>			<Plug>(vimshell_int_delete_forward_line)
" <CR>			<Plug>(vimshell_int_execute_line)
" <C-c>			<Plug>(vimshell_int_interrupt)
" <C-l>			<Plug>(vimshell_int_history_unite)
" <C-v>			<Plug>(vimshell_int_send_input)
" <C-n>			<C-n>
" <TAB>			Select candidate or start completion

" imap <buffer><C-g> <Plug>(vimshell_history_complete)

":p		expand to full path
":h		head (last path component removed)
":t		tail (last path component only)
":r		root (one extension removed)
":e		extension only

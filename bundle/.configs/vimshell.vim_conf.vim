let g:vimshell_prompt = $USER."% "
let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":~")."$", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+$ '
""let g:vimshell_prompt_pattern = ''
"let g:vimshell_user_prompt = ''
"let g:vimshell_max_command_history = 500
let g:vimshell_vimshrc_path	= '~/.vim/vimshrc'
let g:vimshell_disable_escape_highlight = 1
"let g:vimshell_enable_smart_case = 1
"let g:vimshell_interactive_update_time = 500
 
let g:vimshell_force_overwrite_statusline = 1
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
" let g:vimshell_no_default_keymappings = 0
"let g:vimshell_use_terminal_command = 'gnome-terminal -e'

" nmap <silent> \sv :VimShell -toggle -buffer-name=@<CR>
nmap <silent> \ss :lchdir %:p:h<CR>:VimShellCurrentDir -toggle -buffer-name=@ -split-command=split<CR>
" nmap <silent> \st :VimShellTab -create -buffer-name=@<CR>
"

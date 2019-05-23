" YCM Setup {{{
" nnoremap [ycm] <Nop>
" nmap ; [ycm]

let g:EclimFileTypeValidate = 0

" neocomplete do it alreay!
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

let g:ycm_log_level = 'info'
" let g:ycm_global_ycm_extra_conf = '~/.vim/configure/ycm_extra_conf.py'
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf = 0
" 如果tags文件很大, ycmd有存在内存泄露, 未解, 暂时关闭
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_min_num_identifier_candidate_chars = 5
let g:ycm_auto_trigger = 1
let g:ycm_cache_omnifunc = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_disable_for_files_larger_than_kb = 2000
let g:ycm_seed_identifiers_with_syntax = 1	
let g:ycm_complete_in_comments = 0
let g:ycm_use_clangd = 1

" 关闭YCM的诊断信息，这样就可以使用其他静态检查插件
let g:ycm_show_diagnostics_ui = 1
let g:ycm_max_diagnostics_to_display = 20
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_error_symbol = 'E>'
let g:ycm_warning_symbol = 'W>'
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_open_loclist_on_ycm_diags = 1
" 显示当前行错误信息
let g:ycm_echo_current_diagnostic = 1
" let g:ycm_filter_diagnostics = {
"     \ "java": {
"     \      "regex": [ ".*taco.*" ],
"     \      "level": "error",
"     \    }
" \ }

function! s:CustomizeYcmLocationWindow()
    10wincmd _
    wincmd p
endfunction
autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()

function! s:CustomizeYcmQuickFixWindow()
    10wincmd _
    wincmd p
endfunction
autocmd User YcmQuickFixOpened call s:CustomizeYcmQuickFixWindow()

" 文件路径补全等
let g:ycm_complete_in_strings = 1
" let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers = {
            \   'c' : ['->', '.', '(', '[', '&'],
            \   'cpp,objcpp' : ['->', '.', '(', '[', '&', '::'],
            \   'perl' : ['->', '::', ' '],
            \   'php' : ['->', '::', '.'],
            \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
            \   'ruby' : ['.', '::'],
            \   'lua' : ['.', ':'],
            \   'vim' : ['$', '&', 're![\w&$<-][\w:#<>-]*']
            \ }
" Fixme: 这种类型下的补全功能, 隔一个弹出一次
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'nerdtree' : 1,
            \ 'bookmark' : 1,
            \ 'files' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'unite' : 1,
            \ 'logcat' : 1,
            \}
let g:ycm_filetype_whitelist = {
            \ "c":1,
            \ "cpp":1,
            \ "sh":1,
            \ "text":1,
            \ "python":1,
            \ "vim":1,
            \ "java":1,
            \ "markdown":1,
            \ }

" 如果python使用neocomplete, 这里需要把python加进来
let g:ycm_filetype_specific_completion_to_disable = {
            \ 'gitcommit': 1,
            \ 'html': 1,
            \ 'css': 1,
            \}

" ['same-buffer', 'horizontal-split', 'vertical-split', 'new-tab']
let g:ycm_goto_buffer_command = 'same-buffer'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_python_interpreter_path = '/usr/bin/python3'

"youcompleteme  默认tab  s-tab 和 ultisnips 冲突
" let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
" 修改对C函数的补全快捷键，默认是CTRL + space;
let g:ycm_key_invoke_completion = '<C-]>'

autocmd InsertLeave * if pumvisible() == 0|pclose|endif	
"}}}

nnoremap <unique> <silent> [search]] :YcmCompleter GoTo<CR>
nnoremap <unique> <silent> [search]} :YcmDiags<CR>

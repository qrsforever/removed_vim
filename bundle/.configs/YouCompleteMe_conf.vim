" nnoremap [ycm] <Nop>
" nmap ; [ycm]

autocmd InsertLeave * if pumvisible() == 0|pclose|endif	
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

let g:ycm_global_ycm_extra_conf = '~/.vim/configure/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
" 如果tags文件很大, ycmd有存在内存泄露, 未解, 暂时关闭
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_min_num_identifier_candidate_chars = 5
let g:ycm_auto_trigger = 1
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_max_diagnostics_to_display = 10
" 如果设置为1, 补全提示会变成隔一个显示提示,可能和neocomplete.vim冲突,没有复现
let g:ycm_cache_omnifunc= 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_disable_for_files_larger_than_kb = 2000
let g:ycm_seed_identifiers_with_syntax = 1	
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'nerdtree' : 1,
            \ 'bookmark' : 1,
            \ 'files' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'logcat' : 1,
            \}
" ['same-buffer', 'horizontal-split', 'vertical-split', 'new-tab']
let g:ycm_goto_buffer_command = 'same-buffer'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_key_invoke_completion = '<S-TAB>'
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

nnoremap ;g :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap ;b :YcmForceCompileAndDiagnostics<CR>


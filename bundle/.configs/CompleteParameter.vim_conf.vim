inoremap <silent><expr> ( complete_parameter#pre_complete("(")
" smap <s-tab> <Plug>(complete_parameter#goto_next_parameter)
" imap <s-tab> <Plug>(complete_parameter#goto_next_parameter)
" smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" 映射')', 否则在select模式下输入')'会触发neocomplete错误
smap <silent><expr> ) DoNull()

function g:DoNull() "{{{

endfunction "}}}

function g:CompleteParameterFailed(failed_insert) "{{{
    if a:failed_insert =~# '()$'
        return "\<LEFT>"
    else
        return ''
    endif
endfunction "}}}

let g:complete_parameter_log_level = 4
let g:complete_parameter_use_ultisnips_mapping = 1
let g:complete_parameter_py_keep_value = 1

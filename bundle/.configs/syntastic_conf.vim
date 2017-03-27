
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "EE"
let g:syntastic_warning_symbol = "WW"
let g:syntastic_style_error_symbol = "EE"
let g:syntastic_style_warning_symbol = "WW"
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 0
let g:syntastic_loc_list_height = 5

let g:syntastic_python_checkers=['python', 'pyflakes']
let g:syntastic_python_python_exec = '/usr/bin/python3'
let g:syntastic_python_pyflakes_exe = 'python3 -m pyflakes'
" let g:syntastic_python_flake8_args='--ignore=E501'

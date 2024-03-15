let g:Powerline_symbols = 'unicode'
let g:Powerline_theme = 'default'
let g:Powerline_colorscheme = 'solarized256'
let g:Powerline_stl_path_style = 'filename'
let g:Powerline_cache_dir = expand('$VIM_HOME/.cache')
call Pl#Theme#InsertSegment('charcode', 'after', 'filetype')
call Pl#Theme#RemoveSegment('syntastic:errors')

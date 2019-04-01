" Enable history yank source
let g:unite_source_history_yank_enable = 0
let g:unite_enable_split_vertically = 0

let g:unite_source_file_rec_max_cache_files = 0
let g:unite_source_rec_max_cache_files = 0
let g:unite_source_rec_min_cache_files = 120
let g:unite_source_buffer_time_format = "(%Y-%m-%d %H:%M:%S) "
let g:unite_force_overwrite_statusline = 0
let g:unite_ignore_source_files = []
let g:unite_data_directory = "~/.cache/unite"
let g:unite_source_bookmark_directory = '~/.cache/unite/bookmark'
let g:unite_enable_auto_select = 1
let g:unite_source_file_async_command = "ls -la"

if executable('ag')
  " Use ag (the silver searcher)
  " https://github.com/ggreer/the_silver_searcher
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --vimgrep --hidden --ignore ' .
  \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
else
    let g:unite_source_grep_default_opts = '-iRHn'
endif

" tag
let g:unite_source_tag_max_name_length = 26
let g:unite_source_tag_max_kind_length = 8

let g:unite_source_menu_menus = {
    \   "default" : {
    \       "description" : "shortcut for unite-menu",
    \       "command_candidates" : [
    \           ["1. Open xlog dir", "NERDTree /tmp/xlog"],
    \       ],
    \   },
    \}

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

let s:my_mrufilter = {
    \   "name" : "my_mru_filter",
    \   "description" : "Add my mru filter"
    \ }
function! s:my_mrufilter.filter(candidates, context)
    let i = 1
    for candidate in filter(copy(a:candidates), "!has_key(v:val, 'abbr')")
        let path = candidate.action__path
        let candidate.abbr = printf("%3d: ", i)
        let candidate.abbr .= "(" . fnamemodify(path, ":t") . ")"
        let candidate.abbr .= "  " . path . " "
        let candidate.abbr .= strftime(g:unite_source_buffer_time_format, getftime(path))
        let i = i + 1
    endfor
    return a:candidates
endfunction
call unite#define_filter(s:my_mrufilter)
unlet s:my_mrufilter

let s:open_dir = {'is_selectable' : 1}
function! s:open_dir.func(candidates)
    execute NERDTree fnameescape(a:candidate.word)
endfunction
call unite#custom#action('directory_mru', 'switch', s:open_dir)
unlet s:open_dir

call unite#custom#source(
    \ 'file_mru, directory_mru',
    \ 'converters', 
    \ ['my_mru_filter'])

call unite#custom#profile(
    \ 'default', 
    \ 'context', 
    \ {
        \ 'winheight': 30,
        \ 'winwidth': 80,
        \ 'direction': 'dynamictop',
        \ 'verbose': 1,
        \ 'vertical': 0,
        \ 'horizontal': 1,
        \ 'prompt_direction': 'top',
        \ 'update-time': 250,
        \ 'auto-resize': 1,
        \ 'max-multi-lines': 5,
        \ 'multi-line': 0,
    \ })

call unite#custom#profile(
    \ 'files',
    \ 'filters',
    \ 'sorter_rank')

call unite#custom#profile(
    \ 'leftview',
    \ 'context',
    \ {
        \ 'winwidth': 36,
        \ 'direction': 'aboveleft',
        \ 'vertical': 1,
        \ 'horizontal': 0,
    \ })

call unite#custom#source(
    \ 'file_rec, file_rec/async, file_rec/git',
    \ 'max_candidates', 
    \ 1000)

call unite#custom#source(
    \ 'file_mru, directory_mru',
    \ 'max_candidates', 
    \ 120)

call unite#custom#source(
    \ 'buffer, file_rec, file_rec/git',
    \ 'matchers',
    \ ['converter_relative_word', 'matcher_fuzzy', 'matcher_project_ignore_files'])

call unite#custom#source(
    \ 'file_rec/async',
    \ 'matchers', 
    \ ['converter_relative_word', 'matcher_default'])

call unite#custom#source(
    \ 'file_rec, file_rec/async, file_rec/git',
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

nnoremap <silent> [search]a :<C-u>Unite -buffer-name=sources -no-split source<CR>

" Warning conflict with LeaderF and fuzzfinder
" see fuzzfinder: su sU, si, sI
" nnoremap <silent> [search]Y :<C-u>UniteBookmarkAdd %<CR>
" nnoremap <silent> [search]y :<C-u>Unite -buffer-name=bookmark -no-empty bookmark<CR>
" nnoremap <silent> [search]f :<C-u>Unite -buffer-name=files -no-empty -start-insert file_rec/async<CR>
" nnoremap <silent> [search]d :<C-u>Unite -buffer-name=mru -default-action=switch directory_mru<CR>
" nnoremap <silent> [search]g :<C-u>UniteWithCursorWord -buffer-name=grep grep:%<CR>
" nnoremap <silent> [search]x :<C-u>Unite -buffer-name=change change<CR>
nnoremap <silent> [search]v :<C-u>Unite -buffer-name=keymap mapping<CR>
nnoremap <silent> [search]m :<C-u>Unite -buffer-name=unitemenu -profile-name=leftview menu:default<CR>
nnoremap <silent> [search]w :<C-u>UniteResume<CR>

" nnoremap <silent> [search]n :<C-u>Unite -buffer-name=mru file_mru<CR>
" nnoremap <silent> [search]b :<C-u>Unite -buffer-name=buffer buffer<CR>
" nnoremap <silent> [search]R :<C-u>Unite -buffer-name=files -no-split -no-empty -start-insert file_rec/git<CR>
" nnoremap <silent> [search]f :<C-u>Unite -buffer-name=find find:.<CR>

let g:unite_prompt = '» '

function! s:unite_my_settings()
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <C-c> <Plug>(unite_exit)
  imap <buffer> <C-c> <Plug>(unite_exit)
  imap <buffer> jj  <Plug>(unite_insert_leave)
  imap <buffer> <TAB> <Plug>(unite_insert_leave)
  nmap <buffer> <TAB>   <Plug>(unite_loop_cursor_down)
  nmap <buffer> <S-TAB> <Plug>(unite_loop_cursor_up)
  imap <buffer> <c-a> <Plug>(unite_choose_action)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
  imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)
  inoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  nnoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

  " p		|<Plug>(unite_smart_preview)|

  let unite = unite#get_current_unite()
  if unite.buffer_name =~# '^search'
      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
      nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif
endfunction
autocmd FileType unite call s:unite_my_settings()

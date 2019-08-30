"{{{ Setup

let g:bookmark_no_default_key_mappings = 0
let g:bookmark_save_per_working_dir = 0
let g:bookmark_manage_per_buffer = 0
let g:bookmark_auto_save = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_show_warning = 1
let g:bookmark_center = 0
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 0
let g:bookmark_disable_ctrlp = 1

"}}}

" unite.vim
call unite#custom#profile(
    \ 'source/vim_bookmarks',
    \ 'context', {
    \     'winheight': 30,
    \     'direction': 'dynamictop',
    \     'start_insert': 0,
    \     'keep_focus': 1,
    \     'no_quit': 0,
    \ })

call unite#custom#source(
    \ 'vim_bookmarks',
    \ 'converters',
    \ ['converter_vim_bookmarks_short'])

"  n  mg      <Plug>BookmarkMoveToLine
"  n  mjj     <Plug>BookmarkMoveDown
"  n  mkk     <Plug>BookmarkMoveUp
"  n  mx      <Plug>BookmarkClearAll
"  n  mc      <Plug>BookmarkClear
"  n  mp      <Plug>BookmarkPrev
"  n  mn      <Plug>BookmarkNext
"  n  mi      <Plug>BookmarkAnnotate
"  n  mm      <Plug>BookmarkToggle
"  n  ma      <Plug>BookmarkShowAll

" 另一个配合的兄弟插件showmarks.vim + marksbrowser
" n   <leader>mx ClearAll
" n   <leader>mm PlaceMarkToggle
" n   <leader>ma MarksBrowser

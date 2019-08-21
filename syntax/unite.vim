if exists("b:current_syntax")
    finish
endif

"Define colors
highlight BookmarkSignUnite ctermfg=33 ctermbg=NONE  guifg=red guibg=NONE
highlight BookmarkAnnotationSignUnite ctermfg=28 ctermbg=NONE guifg=blue guibg=NONE

syn match FlagSign '⚑' 
syn match BookSign '☰'

hi def link FlagSign BookmarkSignUnite 
hi def link BookSign BookmarkAnnotationSignUnite 

let b:current_syntax = 'unite'

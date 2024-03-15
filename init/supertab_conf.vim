let g:SuperTabDefaultCompletionType = "context"
" autocmd FileType *
            " \ if &omnifunc != '' |
            " \   call SuperTabChain(&omnifunc, "<c-p>") |
            " \ endif
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
            \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

" let g:SuperTabMappingForward = '<tab>'
" let g:SuperTabMappingBackward = '<s-tab>'

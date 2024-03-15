"{{{ Setup
let g:pandoc#filetypes#handled = ["markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#modules#warn_disabled = 0
let g:pandoc#compiler#arguments = '-s --mathjax=https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-MML-AM_CHTML'
" let g:pandoc#modules#disabled = ['folding', 'executors', 'metadata', 'menu',  'keyboard', 'chdir', 'spell', 'hypertext', 'bibliographies', 'formatting']
" vim-pandoc formatting module 修改textwidth, remove this module
let g:pandoc#modules#enabled = ['yaml', 'completion', 'command', 'indent', 'toc']
" because formatting will set textwidth if mode = 's' (h, a, A, s)
" let g:pandoc#formatting#mode = 's'
" let g:pandoc#formatting#textwidth = 86

" let g:pandoc#command#autoexec_on_writes = 1
" let b:pandoc_command_autoexec_command = "Pandoc --output=/tmp/vim-pandoc-gen.html"
" let g:pandoc#command#latex_engine = "xelatex"
let g:pandoc#command#path = "/usr/bin/pandoc"
let g:pandoc#command#use_message_buffers = 0

"}}}

"pandoc test.md -o test.docx
"pandoc --pdf-engine=xelatex test.md -o test.pdf

"Pandoc --output=/tmp/vim-pandoc-gen.html

function! <SID>_CallPandoc(o)
    exec "silent! w!"
    try
        exec "Pandoc --output=/tmp/vim-pandoc-gen.html"
        if a:o == 1
            call system("xdg-open /tmp/vim-pandoc-gen.html")
        endif
    catch
        echomsg "not markdown file"
    endtry
endfunction

command! -nargs=0 XPandocUpdate  :call <SID>_CallPandoc(0)
command! -nargs=0 XPandocBrowser :call <SID>_CallPandoc(1)

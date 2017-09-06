" 将光标位置放到所要搜索的字符串上, 按F7, 默认搜索所有(*)类型文件
"fgrep : 将正则表达式的符号当作字符搜索 eg. $ [a|b]
"
let Grep_Default_Options = '-iI'
let Grep_Skip_Dirs = '.svn .bak tag .git RCS CVS SCCS'
let Grep_Skip_Files = '*.bak *~ *.obj *.o *.bin *.elf tags'
let Grep_OpenQuickfixWindow = 1
let Grep_Null_Device = '/dev/null'
let Grep_Shell_Quote_Char = "'"
let Grep_Default_Filelist = '*'

command! MyGrep call s:DoSelectGrep()

let s:MRUGrepWordsFile = expand('$HOME/.MRUGrepWordsFile')
let s:MaxCount = 30

func ListCandidateWord(A, L, P)
    return system("cat " . s:MRUGrepWordsFile)
endfunc

func! s:InputWords(label)
    if ! filereadable(s:MRUGrepWordsFile)
        call writefile([], s:MRUGrepWordsFile)
    endif
    let grepwords = readfile(s:MRUGrepWordsFile)

    :messages clear
    :redraw
    let tmpstr = input('[' . a:label . '] Search for pattern: ', expand("<cword>"), 'custom,ListCandidateWord')
    if len(tmpstr) < 2
        unlet grepwords
        return ""
    endif
    let outputs = []
    let addflg = 1
    for line in grepwords
        if line == tmpstr
            let addflg = 0
        endif
    endfor 
    if addflg == 1
        call add(outputs, tmpstr)
        let cnt = 1
        for line in grepwords
            if cnt < s:MaxCount
                call add(outputs, line)
            endif
            let cnt += 1
        endfor
        call writefile(outputs, s:MRUGrepWordsFile)
        unlet outputs
    endif
    return tmpstr
endfunc

func! s:DoSelectGrep() 
    echomsg ' Use Shift+F2 Shift+F3 (for next match pattern)'
    echomsg ' 1. lvimgrep(current file)'
    echomsg ' 2. lvimgrep(directory)'
    echomsg ' 3. egrep(current file)'
    echomsg ' 4. regrep(directory)'
    echomsg ' 5. fgrep(current file)'
    echomsg ' 6. fgrep(directory)'
    echomsg ' 7. bgrep(buffer)' 
    echomsg ' 8. cscope'
    echohl Search
    let select = str2nr(input("Select Search Method: ", ' '), 10)         
    echohl None

    " exec "Mark " 
    " let word = s:InputWords()
    exec "lchdir %:p:h"
    exec "cclose"
    if select == 1
        exec "silent! lvimgrep '" . s:InputWords('lvimgrep') . "' " . expand('%')
        exec "belowright lw 15"
    elseif select == 2
        let word = s:InputWords('lvimgrep')
        let startdir = input("Start searching from directory: ", getcwd(), "dir")
        if startdir == ""
            return
        endif
        exec "lvimgrep '" . word . "' " . startdir . "/**/*"
        exec "belowright lw 15"
    elseif select == 3
        exec "Egrep '" . s:InputWords('egrep') . "' " . expand('%')
    elseif select == 4
        exec "Regrep '" . s:InputWords('regrep') . "'"
    elseif select == 5
        exec "Fgrep '" . s:InputWords('fgrep') . "' " . expand('%')
    elseif select == 6
        exec "Fgrep '" . s:InputWords('fgrep') . "' "
    elseif select == 7
        exec "Bgrep '" . s:InputWords('bgrep') . "'"
    elseif select == 8
        exec "QuickFixClear"
        exec "cs find e " . s:InputWords('cs')
        exec "belowright cw 15"
    else
        return
    endif
    " exec "Mark " . word 
    exec "redraw"
endfunc

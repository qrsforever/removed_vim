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

command! -nargs=* -complete=file MyGrep call s:DoSelectGrep(<f-args>)

let s:MRUGrepWordsFile = expand('$HOME/.MRUGrepWordsFile')
let s:MaxCount = 6

func! s:InputWords()
    if ! filereadable(s:MRUGrepWordsFile)
        call writefile([], s:MRUGrepWordsFile)
    endif
    let grepwords = readfile(s:MRUGrepWordsFile)
    let cnt = 0
    let recwords = []
    for w in grepwords
        if count < s:MaxCount  
            call add(recwords, w)
        endif
        let cnt += 1
    endfor
    let i = 1
    echomsg " "
    for line in recwords
        echomsg " " . i . ". " . line
        let i += 1
    endfor

    echohl Search
    let tmpstr = input("Search for pattern: ", expand("<cword>") . "|")
    echohl None
    if len(tmpstr) < 2
        return ""
    endif
    let select = -1
    let ex = split(tmpstr, '|')
    if 1 == len(ex)
        let tmpstr = ex[0]
    else
        if 1 == len(ex[1])
            let select = str2nr(ex[1], 10)         
        endif
    endif
    let outputs = []
    if select > 0 && select <= cnt
        let tmpstr = recwords[select - 1]
    else 
        let addflg = 1
        for line in recwords
            if line == tmpstr
                let addflg = 0
            endif
        endfor 
        if addflg == 1
            call add(outputs, tmpstr)
            let cnt = 1
            for line in recwords
                if cnt < s:MaxCount
                    call add(outputs, line)
                endif
                let cnt += 1
            endfor
            call writefile(outputs, s:MRUGrepWordsFile)
        endif
    endif
    let tokpos = stridx(tmpstr, '|')
    if tokpos < 0
        return tmpstr
    endif
    
    let twd = split(tmpstr, '|')
    let len = len(twd)
    let words=''
    let i = 0
    while i < len
        if i == 0
            let words = twd[i]
        else
            let words = words . '\|' . twd[i]
        endif
        let i = i + 1
    endwhile
    return words
endfunc

func! s:DoSelectGrep() 
    echomsg ' Use Shift+F2 Shift+F3 (for next match pattern)'
    echomsg ' 1. in directory'
    echomsg ' 2. in current file'
    echomsg ' 3. in files'
    echomsg ' 4. in buffer' 
    echomsg ' 5. in cscope'
    echohl Search
    let select = str2nr(input("Select Search Method: ", ' '), 10)         
    echohl None
    
    exec "Mark " 
    let word = s:InputWords()
    if select == 1
        exec "Rgrep " . word 
    elseif select == 2
        exec "silent! lvimgrep " . word . " " . expand('%')
        exec "belowright lw 15"
    elseif select == 3
        exec "Grep " . word
    elseif select == 4
        exec "Bgrep " . word
    elseif select == 5
        exec "cs find e " . word
        exec "belowright cw 15"
    else
        return
    endif
    exec "Mark " . word 
    exec "redraw"
endfunc

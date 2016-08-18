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

func! s:DoSelectGrep() 
    echomsg ' Use Shift+F2 Shift+F3 (for next match pattern)'
    echomsg ' 1. in directory'
    echomsg ' 2. in current file'
    echomsg ' 3. in files'
    echomsg ' 4. in buffer' 
    echomsg ' 5. in cscope'
    let select = str2nr(input("Select Search Method: ", ' '), 10)         
    
    if select == 1
        exec "Rgrep"
    elseif select == 2
        let word = input("Search for pattern ", expand("<cword>"), "tag")
        exec "lvimgrep " . word . " " . expand('%')
        exec "belowright lw 15"
    elseif select == 3
        exec "Grep"
    elseif select == 4
        exec "Bgrep"
    elseif select == 5
        let word = input("Search for pattern ", expand("<cword>"), "tag")
        exec "cs find e " . word
        exec "cw"
    else
        return
    endif
    exec "redraw"
endfunc

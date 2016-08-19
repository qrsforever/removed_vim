"个人的openkey, 可以自己申请
let g:api_key = "356090979"
let g:keyfrom = "lovezyt"

"lidong 个人添加, 不依赖网络， 翻译托福4500多个单词
let g:trv_grep = "grep"       "搜索的命令
let g:trv_grepOptions = "-i"    "Grep命令参数忽略大小写
let g:trv_dictionary = "~/.vim/dict/toefl_eng.txt"  "Grep搜索单词的文件 toefl_eng.txt: 托福4000多个单词

func! GetTransLoc() 
    let word = input("Dict: ", expand("<cword>"), "buffer")
    if (word == "")
        echo "No word can translate!"
        return 0
    endif
    echomsg ' '
    let cmd = g:trv_grep . " " . g:trv_grepOptions . " " . "\"\\\<" . word  . "\\\>\"" . " " . g:trv_dictionary
    let len0 = len(word)
    let result = system(cmd)
    if (result == "")
        exec 'Dict ' . word
    else 
        let len1 = len(result)
        echomsg word . " ==> " . result[len0+1:len1-2]
    endif
endfunc

nmap <silent> <leader>tr :call GetTransLoc()<CR>

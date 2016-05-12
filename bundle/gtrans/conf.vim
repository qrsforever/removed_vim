"初始可以翻译为三种语言：
"    en : 英语
"    zh : 简体中文
"    tw : 繁体中文
let g:gtrans_DefaultLang = 'zh'

"目前只支持 bing 和 google
let g:gtrans_Engine = 'bing' " ['google', 'bing']

"lidong 个人添加, 不依赖网络， 翻译托福4000多个单词
let g:trv_grep = "grep"       "搜索的命令
let g:trv_grepOptions = "-i"    "Grep命令参数忽略大小写
let g:trv_dictionary = "~/.vim/dict/toefl_eng.txt"  "Grep搜索单词的文件 toefl_eng.txt: 托福4000多个单词

func! GetTransLoc(...) 
    let s:word = expand("<cword>")
    if (s:word == "")
        echo "No word can translate!"
        return 0
    endif
    let cmd = g:trv_grep . " " . g:trv_grepOptions . " " . "\"\\\<" . s:word  . "\\\>\"" . " " . g:trv_dictionary

    "暂时将结果存放到寄存器Z中
    let result = system(cmd)
    if (result == "")
        let @z="Can't find the word \"" . s:word  . "\" in " . g:trv_dictionary 
    else 
        let @z=result
    endif
	if bufexists("TransWindow") > 0
		sil! bwipeout TransWindow
	endif

	silent rightbelow new TransWindow

	if bufexists("TransWindow") > 0
        "将寄存器z中的内容复制到buffer中
		sil normal "zP
		resize 5
        setlocal bufhidden=wipe buftype=nofile
        setlocal nobuflisted nomodifiable noswapfile nowrap
        nnoremap <buffer> <silent> q :hide<CR>
	endif
endfunc


map <leader>gt :call GetTrans()<CR>
map <leader>gv :call GetTransVis()<CR>
map <leader>gl :call GetTransLoc()<CR>

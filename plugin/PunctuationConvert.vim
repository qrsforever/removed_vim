" 将中文的标点符号转化为英语
command! MyPunctuationConvert call s:_PunctuationConvert()
function! s:_PunctuationConvert() "{{{
   :silent! %s/，/,/g
   :silent! %s/。/./g
   :silent! %s/、/\ /g
   :silent! %s/？/?/g
   :silent! %s/！/!/g
   :silent! %s/；/;/g
   :silent! %s/：/:/g
   :silent! %s/“/"/g
   :silent! %s/”/"/g
   :silent! %s/‘/'/g
   :silent! %s/’/'/g
   :silent! %s/（/(/g
   :silent! %s/）/)/g
endfunction "}}}

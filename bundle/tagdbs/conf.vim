command! -nargs=* -complete=file MyTags call s:DoSelectTagDB(<f-args>)

func! s:DoSelectTagDB(...)
    let tagdir = $tags
    if len(tagdir) == 0
        echomsg 'set env tags dir, you can add export tags=your_tag_dir into ~/.profile'
        echomsg ' 1. 创建一个专门存放不同工程总Tag的目录 '
        echomsg '    eg. mkdir -p /home/lidong/Workspace/tags '
        echomsg ' 2. 设置系统环境变量tags指向总Tag的目录'
        echomsg '    eg. export tags=/home/lidong/Workspace/tags (可以写到~/.profile) '
        echomsg ' 3. 增加需要创建Tag的不同工程的目录 '
        echomsg '    eg. mkdir -p /home/lidong/Workspace/tags/myproject1 '
        echomsg ' 4. 将脚本script/*.sh拷贝到工程目录中 '
        echomsg '    eg. cp script/*.sh /home/lidong/Workspace/tags/myproject1 '
        echomsg ' 5. 修改sh.sh文件, 指定工程源码路径即可'
        echomsg '    eg. SRC_DIRS="/home/lidong/Workspace/source/myproject1"'
        echomsg ' 6. 在工程目录里, 执行source sh.sh生成需要的tags, filenametags, cscope'
        echomsg '    eg. cd /home/lidong/Workspace/tags/myproject1; source sh.sh '
        return
    endif
    echomsg "   Input 0(./tags) or  88 (libc) or 99 (cpp)"
    let subdirs = [ ]
    if vimshell#util#has_vimproc()
        let dirs = vimproc#readdir(tagdir)
        let i = 0
        for subdir in dirs
            let i = i + 1
            let subdir = substitute(subdir, '\/$', '', '')
            if isdirectory(subdir)
                echomsg ' ' . i . ' ' . subdir
                call add(subdirs, subdir)
            endif
        endfor

        let tmpstr = input("Select TagDB: ", ' ')
        let tokpos = stridx(tmpstr, '+')
        if tokpos > 0
            let select = str2nr(strpart(tmpstr, tokpos+1), 10)         
        else 
            set tags=./tags
            let select = str2nr(tmpstr, 10)         
        endif
        echomsg ' '

        if select > i || i == 0 || select == 0
            if select == 0
                set tags=./tags    
            elseif select == 99
                set tags+=~/.vim/tags/include.tags
                set tags+=~/.vim/tags/cpp.tags
                echomsg ' tags: cpp include!'
            elseif select == 88
                set tags+=~/.vim/tags/libc.tags
                set tags+=~/.vim/tags/glib.tags
                echomsg ' tags: libc glib!'
            else 
                echomsg ' Not found db.vim!'
            endif
            return
        endif

        let select = select -1

        " commont off templatly.
        " set tags+=~/.vim/tags/include.tags
        " set tags+=~/.vim/tags/cpp.tags

        let dbfile = subdirs[select] . '/db.vim'
        if filereadable(dbfile)
            exec 'source ' . dbfile
            exec "redraw"
        else 
            echomsg ' Not found db.vim!'
            return 
        endif
    endif
endfunc

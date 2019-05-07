Use:

1. 要求vim版本：vim8.0 or high 

2. 管理插件: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

3. 安装插件: Open vim, 执行:PluginInstall

4. cd bundle/vimproc.vim; make -f make_unix.mk

5. 保证系统clang版本3.9 or high， 到YouCompleteMe执行python3 ./install.py --clang-completer --clangd-completer or --all (时间比较久)
    ./install.py --clangd-completer --clang-completer --go-completer --ts-completer --java-completer
    python3: 修改一下install.sh

6. jedi补全sudo pip3 install -U jedi
    git clone https://github.com/davidhalter/jedi
    sudo python setup.py install
    or
    (推荐)
    sudo pip3 install -e git://github.com/davidhalter/jedi.git#egg=jedi

    安装numpydoc:
    sudo apt-get install python-numpydoc
    sudo apt-get install python3-numpydoc (ubuntu16)

    补全(某些)时有个错误:
    docscrape.py:140: UserWarning: Unknown section Note
    打开文件加一个"Note" Section


7. 使用universal-ctags, https://github.com/universal-ctags/ctags 下载编译

8. 使用markdown, 并根据对应的配置里面的说明进行修改
    `npm -g install instant-markdown-d`

9. Js
   `cd bundle/tern_for_vim; npm install`
    sudo npm i -g eslint eslint-plugin-vue

10. fzf
    把export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vim {})'" 放到~/.fzf.bash
    cd ./bundle/fzf/; ./install --all
    sudo apt-get install silversearcher-ag

    sudo apt-get install ripgrep (ubuntu18.10)
    or
    git clone https://github.com/BurntSushi/ripgrep
    cd ripgrep ; cargo build --release; ./target/release/rg --version
    or 
    cargo install ripgrep (推荐)

11. LeaderF
    cd ./bundle/LeaderF; ./install.sh

12. jupyter
    ```
    sudo pip3 install jupyter_contrib_nbextensions
    jupyter nbextensions_configurator enable --user
    # Now clone the repository
    cd $(jupyter --data-dir)/nbextensions
    git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
    chmod -R go-w vim_binding
    jupyter nbextension enable vim_binding/vim_binding

    配置jupyter
    jupyter notebook --generate-config
    jupyter notebook password
    ```


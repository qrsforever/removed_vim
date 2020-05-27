Use: 1

0. 中文字体(尤其登陆远端服务器)

    sudo locale-gen zh_CN.UTF-8
    sudo locale -a | grep "zh"

    下载SimHei.ttf: https://pan.baidu.com/s/15iwAcVLCdOnCgRRZ1rtauQ 提取码: mpts 

    mkdir -p ~/.fonts
    mv SimHei.ttf ~/.fonts
    fc-cache -vf  # 刷新系统字体缓存

1. 要求vim版本：vim8.0 or high 

2. 管理插件: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

3. 安装插件: Open vim, 执行:PluginInstall

4. cd bundle/vimproc.vim; make -f make_unix.mk

5. 保证系统clang版本3.9 or high
    某些库下载 链接: https://pan.baidu.com/s/1jid3TQMpDw3r1I0Nn57xcA 提取码: jiu6
    git submodule sync
    git submodule update --init --recursive
    python3 ./install.py --clangd-completer --clang-completer --go-completer --ts-completer --java-completer
    # (apt install clang)

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

    see extern/README.md

11. LeaderF
    cd ./bundle/LeaderF; ./install.sh

12. jupyter

    ```
    sudo pip3 install -U \
        jupyter \
        jupyter_contrib_nbextensions \
        jupyter_nbextensions_configurator \
        -i https://pypi.tuna.tsinghua.edu.cn/simple

    sudo pip3 install -U jupyterthemes (可选)
    sudo pip3 install -U ipywidgets

    sudo jupyter contrib nbextension install --sys-prefix
    sudo jupyter nbextensions_configurator enable
    # Now clone the repository
    cd $(jupyter --data-dir)/nbextensions
    git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
    chmod -R go-w vim_binding
    jupyter nbextension enable vim_binding/vim_binding
    jupyter nbextension enable --py widgetsnbextension

    配置jupyter
    jupyter notebook --generate-config
    jupyter notebook password
    ```

13. 语法检查

    sudo apt-get install pyflakes
    sudo apt-get install python-flake8 (推荐)

14. 数学公式

    sudo apt-get install texlive

15. 画动物
  
    sudo apt-get install boxes

16. jsonnet

    编译安装: https://github.com/google/jsonnet
    make -j4; sudo make install
    sudo pip3 install jsonnet

    https://github.com/qrsforever/vim-jsonnet


17. gotags (go install: https://golang.google.cn/doc/install)
    
    go get -u github.com/jstemmer/gotags

# error:

1. Gtk-Message: Failed to load module "canberra-gtk-module"

    sudo apt install libcanberra-gtk-module


2. error: RPC failed; curl 56 GnuTLS recv error (-54): Error in the pull function.

    https://stackoverflow.com/questions/38378914/git-error-rpc-failed-curl-56-gnutls
    # 定位错误原因
    export GIT_TRACE_PACKET=1; export GIT_TRACE=1; export GIT_CURL_VERBOSE=1
    git config --global http.postBuffer 524288000
    # 如果上述方法不行, 只下载最新的代码(不下载tag及历史版本)
    git clone --depth=1


```
git config --global url."github.com/".insteadOf "https://github.com.cnpmjs.org/"
or 
git config --global url."github.com/".insteadOf "https://hub.fastgit.org/"
```

Use: 1

0. 中文字体(尤其登陆远端服务器)

    sudo apt-get -y install language-pack-zh-hans language-pack-zh-hans-base

    到https://github.com/ryanoasis/nerd-fonts/releases 下载UbuntuMono.zip放到~/.fonts
    并设置terminator font

    fc-list

    sudo locale-gen zh_CN.UTF-8
    sudo locale -a | grep "zh"

    下载SimHei.ttf: https://pan.baidu.com/s/15iwAcVLCdOnCgRRZ1rtauQ 提取码: mpts 
    or wget https://gitee.com/qrsforever/sysfonts/raw/master/simhei.ttf [simsun.ttc]

    mkdir -p ~/.fonts
    mv simhei.ttf ~/.fonts
    fc-cache -vf  # 刷新系统字体缓存
    fc-list :lang=zh-cn


1. 要求vim版本：vim8.0 or high 

2. ~~管理插件: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim~~

3. 安装插件: Open vim, 执行:PluginInstall

4. cd bundle/vimproc.vim; make -f make_unix.mk

5. YCM: 保证系统clang版本3.9 or high
    sudo apt install gcc-9 g++-9 golang clang libclang-dev
    export GOPROXY=https://goproxy.io
    export GO111MODULE=on

    sudo python3 install.py --clang-completer --go-completer --system-libclang --force-sudo --verbose
    # git submodule update --init --recursive --jobs=$(nproc)


    下载相应的clangd
        https://github.com/ycm-core/llvm/releases

    Install
        https://github.com/ycm-core/YouCompleteMe/wiki/Full-Installation-Guide
        
        LLVM_ROOT=/home/lidong/.vim/extern/clang+llvm-15.0.1-x86_64-unknown-linux-gnu
        CC=gcc CXX=g++ EXTRA_CMAKE_ARGS="-DPATH_TO_LLVM_ROOT=$LLVM_ROOT" python3 install.py --clang-completer --go-completer --verbose

    or:
        1. YouCompleteMe/third_party/ycmd/cpp/ycm/CMakeLists.txt:
            GIT_REPOSITORY https://hub.fastgit.org/abseil/abseil-cpp
            GIT_TAG 3b4a16abad2c2ddc494371cc39a2946e36d35d11
            SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/absl
        2. YouCompleteMe/third_party/ycmd/build.py: DownloadClangd
            wget https://github.91chifun.workers.dev/https://github.com/ycm-core/llvm/releases/download/12.0.0/clangd-12.0.0-x86_64-unknown-linux-gnu.tar.bz2
            file_name = f'/home/lidong/.vim/bundle/YouCompleteMe/{ file_name }'  # p.join( CLANGD_CACHE_DIR, file_name )

    # Ubuntu18.04
    CC=gcc-9 CXX=g++-9 python3 ./install.py --clangd-completer

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
    
    /usr/local/lib/python3.6/dist-packages/matplotlib/mpl-data/fonts/ttf/SimHei.ttf

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
    or:
    sudo apt-get install flake8 python-flake8
    or:
    sudo python3 -m pip install flake8 (推荐)

14. 数学公式

    sudo apt-get install texlive

15. 画动物
  
    sudo apt-get install boxes

    Interactive ASCII art diagram generators:
    diagon: https://github.com/ArthurSonzogni/Diagon/releases

16. jsonnet

    编译安装: https://github.com/google/jsonnet
    make -j4; sudo make install
    sudo pip3 install jsonnet

    https://github.com/qrsforever/vim-jsonnet


17. gotags (go install: https://golang.google.cn/doc/install)
    
    go get -u github.com/jstemmer/gotags


18. deoplete.nvim

    pip3 install --user --upgrade pynvim


## xsel and xclip
    sudo apt install xclip xsel


## notify-send

    https://github.com/andreztz/notify-send
    sudo apt install libcairo2-dev libgirepository1.0-dev
    pip3 install notify-send


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


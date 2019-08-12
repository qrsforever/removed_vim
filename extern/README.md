支持instant-markdown-ext.git
----------------------------
1. git clone git@github.com:qrsforever/instant-markdown-ext.git
2. npm install
3. cd ../bin && ln -s ../extern/instant-markdown-ext/instant-markdown-d instant-markdown-d


个人本地博客
-----------
1. git clone git@github.com:qrsforever/git-blog-setting.git
2. npm install

ripgrep
-------

git clone https://github.com/BurntSushi/ripgrep


ycm-generator
-------------

git clone https://github.com/rdnetto/YCM-Generator.git


fzf
-----

git clone --depth 1 https://github.com/junegunn/fzf.git
cd ./fzf ; ./install --all
` export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vim {})'" >> ~/.fzf.bash `


lua
------

[lua](https://jaist.dl.sourceforge.net/project/luabinaries/5.3.5/Docs%20and%20Sources/lua-5.3.5_Sources.tar.gz)
    
    apt-get install libreadline-dev
    INSTALL_TOP= /usr/local/ 
    make linux; sudo make install
    

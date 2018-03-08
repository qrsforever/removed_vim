" Setup {{{
" npm -g install instant-markdown-d
" 扩大页面显示, 手动修改/usr/lib/node_modules/instant-markdown-d/github-markdown.css 和 index.html
" github-markdown.css:
"   .container {
"    	width: 85%;
"   	margin-right: auto;
"   	margin-left: auto
"	}
" .repository-with-sidebar .repository-content {
"     /* float: left; */
"     width: 100%;
" }
"
" .repository-with-sidebar.with-full-navigation .repository-content {
"     width: 100%;
" }
"
" index.html:
"   .markdown-body {
"     min-width: 200px;
"     max-width: 100%;
"     margin: 0 auto;
"     padding: 30px;
"   }
"
let g:instant_markdown_autostart = 0
let g:instant_markdown_slow = 1
"}}}

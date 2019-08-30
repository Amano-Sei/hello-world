
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file (restore to previous version)
	if has('persistent_undo')
		set undofile	" keep an undo file (undo changes after closing)
	endif
endif

if &t_Co > 2 || has("gui_running")
	" Switch on highlighting the last used search pattern.
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
	packadd! matchit
endif

"set shortmess=atI			" 启动的时候不显示援助乌干达儿童的提示
"winpos 5 5				" 设定窗口位置
"set lines=40 columnd=155		" 设定窗口大小
"set nu					" 设定行号
set go=					" 不要图形按钮
"color asmanian2			" 设置背景主题
set guifont=Courier_New:h10:cANSI	" 设置字体
"syntax on				" 语法高亮
autocmd InsertLeave * se nocul		" 用浅色高亮当前行
autocmd InsertEnter * se cul		" 用浅色高亮当前行
set ruler				" 显示标尺
set showcmd				" 输入的命令显示出来，看的清楚些
"set cmdheight=1			" 命令行（在状态行下）的高度，设置为1
"set whichwrap+=<,>,h,l			" 允许backspace和光标键跨越行边界
"set scrolloff=3			" 光标移动到buffer的顶部和底部时保持3行距离
"set novisualbell			" 不要闪烁（不知道是啥）
set laststatus=1			" 启动显示状态行(1),总是显示状态行(2)
set foldenable				" 允许折叠
set foldmethod=manual			" 手动折叠
"set background=dark			" 背景使用黑色
set nocompatible			" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限

" 显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif

" 设置配色方案
"colorscheme murphy

" 字体
"if (has("gui_runing"))
" 	set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
"endif

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

" 自动为.cpp .c .h .sh .java 添加文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
func SetTitle()
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#########################################################################") 
		call append(line("."), "\# File Name: ".expand("%")) 
		call append(line(".")+1, "\# Author: Amano Sei") 
		call append(line(".")+2, "\# mail: amano_sei@outlook.com") 
		call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+4, "\#########################################################################") 
		call append(line(".")+5, "\#!/bin/bash") 
		call append(line(".")+6, "") 
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "    > File Name: ".expand("%")) 
		call append(line(".")+1, "    > Author: Amano Sei") 
		call append(line(".")+2, "    > Mail: amano_sei@outlook.com ") 
		call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if &filetype == 'cpp'
        call append(line(".")+6, "#include <cstdio>")
		call append(line(".")+7, "#include <iostream>")
		call append(line(".")+8, "#include <cstring>")
		call append(line(".")+9, "#include <algorithm>")
		call append(line(".")+10, "using namespace std;")
		call append(line(".")+11, "")
		call append(line(".")+12, "int main(){")
		call append(line(".")+13, "\treturn 0;")
		call append(line(".")+14, "}")
		call append(line(".")+15, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G
endfunc 

" 键位映射
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

map <F3> ggVGYggVG"+y
map <F3> <Esc> ggVGYggVG"+y
map <F12> gg=G

vmap <C-c> "+y
nnoremap <F2> :g/^\s*$/d<CR>
"nnoremap <C-F2> :vert diffsplit

map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

set autoread				" 设置当文件被改动时候自动载入
"quickfix ???
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
set completeopt=preview,menu		" 自动补全
"filetype plugin on			" 允许插件
set clipboard+=unnamed			" 共享剪切板
set nobackup
set noswapfile
" 从不备份

"make运行
:set makeprg=g++\ -Wall\ \ %
set autowrite				" 自动保存
set cursorline				" 突出显示当前行
set cursorcolumn			" 突出显示当前列
hi CursorLine cterm=bold ctermbg=black
hi CursorColumn cterm=none ctermbg=black
set magic				" 设置魔术???
set cindent
set tabstop=4				" 设置缩进为4格
set softtabstop=4
set shiftwidth=4
set expandtab				
" 用空格代替制表符???
set smarttab				" 在行和段开始处使用制表符
set number				" 显示行号
set ignorecase				" 设置忽略大小写
set incsearch
set gdefault
set enc=utf-8
set langmenu=zh_CN.UTF-8
set laststatus=2			" 总是显示状态行
filetype on
"filetype plugin on
filetype indent on

set viminfo+=!				" 保存全局变量
set iskeyword+=_,$,@,%,#,-		" 带有如下符号的单词不要被换行分割
set linespace=0				" 字符间插入的像素行数目
set wildmenu				" 增强模式中的命令行自动完成操作
set backspace=2				" 使backspace正常处理indent, eol, start等
set mouse=a				" 允许使用鼠标（我是个辣鸡
set selection=exclusive
set selectmode=mouse,key

set report=0				" ???通过commands命令知道哪一行被修改了
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
"在被分割的窗口间显示空白，便于阅读
set showmatch				" 高亮显示匹配的括号
set matchtime=1				" 匹配括号高亮的时间(.1s)
set smartindent				" 为C程序提供自动缩进


"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
:inoremap " <c-r>=ClosePairQt('"')<CR>
:inoremap ' <c-r>=ClosePairQt("'")<CR>

:inoremap , <c-r>=ClosePair(",")<CR>
:inoremap ; <c-r>=ClosePair(";")<CR>

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
function! ClosePairQt(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Left>" 
    endif
endfunction

set completeopt=longest,menu

:inoremap <backspace> <c-r>=Mybksp()<CR>
function! Mybksp()
    let linelast = getline('.')[col('.')-1]
    let linelastbefore = getline('.')[col('.')-2]
    if linelast == linelastbefore && (linelast == "'" || linelast == '"') || linelast == ']' && linelastbefore == '[' || linelast ==')' && linelastbefore == '('|| linelast == '}' && linelastbefore == '{'
        return "\<Right>\<backspace>\<backspace>"
    else
        return "\<backspace>"
    endif
endfunction

set noundofile


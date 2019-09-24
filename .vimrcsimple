set ruler
set number
syntax on
set nocompatible
set autoread
set autowrite
set cursorline
set cursorcolumn
set background=dark
hi CursorLine cterm=bold ctermbg=black
hi CursorColumn cterm=none ctermbg=black
set magic
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set enc=utf-8
set laststatus=2
set showmatch
set ignorecase
set showcmd
filetype on
filetype indent on

autocmd BufNewFile *.cpp exec ":call SetTitle()"
func SetTitle()
    call setline(1, "#include <iostream>")
    call append(line("."), "#include <cstdio>")
    call append(line(".")+1, "#include <algorithm>")
    call append(line(".")+2, "#include <cstring>")
    call append(line(".")+3, "#include <cstdlib>")
    call append(line(".")+4, "#include <cmath>")
    call append(line(".")+5, "")
    call append(line(".")+6, "using namespace std;")
    call append(line(".")+7, "")
    call append(line(".")+8, "int main(){")
    call append(line(".")+9, "")
    call append(line(".")+10, "\treturn 0;")
    call append(line(".")+11, "}")
    call append(line(".")+12, "")
endfunc

:inoremap ( ()<ESC>i
:inoremap [ []<ESC>i
:inoremap { {<CR>}<ESC>O

:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap } <c-r>=ClosePair('}')<CR>

:inoremap " <c-r>=ClosePairQT('"')<CR>
:inoremap ' <c-r>=ClosePairQT("'")<CR>

function! ClosePair(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char"
    endif
endfunction

function! ClosePairQT(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Left>"
    endif
endfunction

:inoremap <backspace> <c-r>=Mybksp()<CR>

function! Mybksp()
    let ll = getline('.')[col('.')-1]
    let llb = getline('.')[col('.')-2]
    if ll==llb && (ll=='"' || ll=="'") || ll == '}' && llb == '{' || ll == ')' && llb == '(' || ll == ']' && llb == '['
        return "\<Right>\<backspace>\<backspace>"
    else
        return "\<backspace>"
endfunction

map <F5> :call Crgcc()<CR>

function! Crgcc()
    exec "w"
    exec "!g++ % -o %<"
    exec "!./%<"
endfunction



"=====================================
"	FileName: 	.vimrc
"	Author:		Ying_xd
"	Email:		Ying_xd@zju.edu.cn
"	Date:		2015/6/17
"=====================================

"=====================================
"       Vim Configuration
"=====================================


" === Basic Configuration === "{{{
set nocompatible
set backspace=indent,eol,start

"高亮
syntax on

set number
"显示光标信息
set ruler
"匹配模式
set showmatch
"突出显示当前行
set cursorline

"C/C++方式对齐
set autoindent
set cindent


"取消备份
set nobackup
set noswapfile

"关闭自动换行
set nowrap
"设置Tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

"设置编码方式
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,gb18030
" 设置编码值
set termencoding=gbk
"制定配色为256色
set t_Co=256
"设定在Vim中可使用鼠标
"set ouse=a
"设置高亮主题
colorscheme molokai

filetype plugin indent on
"}}}

" === fold ==="{{{
" 标志折叠
set foldmethod=marker 
set foldmarker={{{,}}}
" set foldmethod=manual
nnoremap <space> za
"}}}
" === Vundle === " {{{
"filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
" -- vundle ---
Bundle 'gmarik/vundle'

" -- PowerLine --
Bundle 'Lokaltog/vim-powerline'
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'

" -- TagList --
Bundle 'taglist.vim'

" -- NERDTree --
Bundle 'scrooloose/nerdtree'

Bundle 'snipMate'

" -- Conque-Shell --
Bundle 'oplatek/Conque-Shell'

call vundle#end()
" }}}
"filetype plugin indent on
" === Taglist ==="{{{
nmap <F3> :Tlist<CR>
imap <F3> <Esc>: Tlist<CR>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Ctags_Cmd="/usr/bin/ctags"
"}}}

" === Key Map ===
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" === NerdTree === "{{{
nmap <F2> :NERDTreeToggle<CR>
imap <F2> <ESC> : NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
"let NERDTreeChDirMode=2  "选中root即设置为当前目录
""let NERDTreeQuitOnOpen=1 "打开文件时关闭树
let NERDTreeShowBookmarks=1 "显示书签
let NERDTreeMinimalUI=1 "不显示帮助面板
let NERDTreeDirArrows=0 "目录箭头 1 显示箭头  0传统+-|号
"}}}

" === Calendar === "{{{
let g:calendar_date_endian      = "big"
let g:calendar_date_separator   = "-"
let g:calendar_view             = "day"
let g:calendar_views            = ['year', 'day', 'month', 'week', 'clock', 'days']
"}}}

" === ConqueTerm === "{{{
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_InsertOnEnter = 1
function ConqueTermMode()
    setlocal tw=0
    setlocal nolist
    setlocal nospell
    " Work-around the bug with Tlist
    inoremap <buffer> <c>h <esc><c-w>h
    inoremap <buffer> <c>j <esc><c-w>j
    inoremap <buffer> <c>k <esc><c-w>k
    inoremap <buffer> <c>l <esc><c-w>l
    inoremap <buffer> <esc><c-w>h <esc><c-w>h
    inoremap <buffer> <esc><c-w>j <esc><c-w>j
    inoremap <buffer> <esc><c-w>k <esc><c-w>k
    inoremap <buffer> <esc><c-w>l <esc><c-w>l
endfunction
command -nargs=0 ConqueTermMode call ConqueTermMode()
au! FileType conque_term ConqueTermMode
" -- key map --
nmap ctb :ConqueTermSplit bash<cr> <esc>:resize 10<cr>i
nmap ctp :ConqueTermSplit python<cr> <esc>:resize 10<cr>i
"}}}

" === Copy Right === "{{{
imap <F4> <esc>:call TitleDet()<cr>
map <F4> :call TitleDet()<cr>
function AddTitle()
    call append(0,"//==================================================//")
    call append(1,"// Author        : Ying XD")
    call append(2,"// Email         : ying_xd@zju.edu.cn")
    call append(3,"// Last modified : ".strftime("%Y-%m-%d %H:%M"))
    call append(4,"// Filename      : ".expand("%:t"))
    call append(5,"// Description   : ")  
    call append(6,"//===================================================//")
    echohl WarningMsg | echo "Successful in adding the copyringht." | echohl None
endf
function UpdateTitle()
    normal m'
    execute '/\/\/ *Last modified :/s@:.*$@\=": ".strftime("%Y-%m-%d %H:%M")'
    normal ''
    normal mk
    execute '/\/\/ *Filename      :/s@:.*$@\=": ".expand("%:t")@'
    execute 'noh'
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endf

function TitleDet()
    let n=1
    while n < 6
        let line = getline(n)
        if line =~ '^//\s*\S*Last\smodified\s*:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction
"}}}


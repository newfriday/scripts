set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

set cscopequickfix=s-,c-,d-,i-,t-,e-
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	elseif $CSCOPE_DB!=""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

syntax on
" tab宽度和缩进同样设置为4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set nocompatible

" TagList 配置
" 设置vim打开文件时自动打开函数列表
let Tlist_Auto_Open=0
" 只显示一个文件的taglist
let Tlist_Show_One_File = 1
" 最后一个窗口是taglist时,vim退出
let Tlist_Exit_OnlyWindow = 1
" 设置手动打开函数列表的快捷键
nmap tl :TlistToggle<cr>

"设置winmanager快捷键
nmap wm :WMToggle<cr>

"设置nerdtree快捷键
nmap nt :NERDTreeToggle<cr>

nmap <Leader>b :CtrlPBuffer<cr>
"cscope nmap"
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>

" 你在此设置运行时路径
set rtp+=/root/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle插件 管理其它所有插件的插件
Plugin 'gmarik/Vundle.vim'

" nerdtree 目录树插件
Plugin 'scrooloose/nerdtree'
Plugin 'winmanager'
Plugin 'taglist.vim'
Plugin 'ctrlp.vim'
Plugin 'cscope'
Plugin 'minibufexplorerpp'

"所有插件都应该在这一行之前
call vundle#end()

" filetype off
filetype plugin indent on

"nerdtree 自动打开目录树
"autocmd vimenter * NERDTree

"nerdtree 关闭文件时目录树自动关闭
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"nerdtree vim不打开文件时同样打开目录树
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"nerdtree vim打开文件时默认光标在文件的编辑区
"wincmd w
"autocmd VimEnter * wincmd w
"
"自动删除行尾空白
autocmd BufWritePre *.py call vundle#scripts#strip_trailing()
autocmd BufWritePre *.h call vundle#scripts#strip_trailing()
autocmd BufWritePre *.c call vundle#scripts#strip_trailing()
autocmd BufWritePre *.S call vundle#scripts#strip_trailing()
autocmd BufWritePre *.cpp call vundle#scripts#strip_trailing()
autocmd BufWritePre Makefile call vundle#scripts#strip_trailing()

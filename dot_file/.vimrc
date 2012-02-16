set rtp+=~/Code/go/misc/vim

syntax enable "打开语法高亮
set cursorline "当前行高亮
set ignorecase smartcase "搜索时忽略大小写
set so=5 "距离5行开始翻页

au BufWritePre * sil %s/\s\+$//e "保存文件时自动删除行尾空格或Tab
au BufWritePre * %s/^$\n\+\%$//ge "删除文件尾多余的空行
set list "显示tab和行尾空格
set listchars=tab:>·,trail:·

if has('gui_running')
  set guifont=Menlo:h14
  colorscheme Tomorrow-Night
endif

filetype on  "自动检测文件类型
filetype indent on "支持文件缩进
filetype plugin on "支持文件插件
set nocompatible  "忽略与vi的兼容性

set viminfo^=! "加入recently accessed菜单

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)

" Formatting (some of these are for coding in C and C++)
set tabstop=4  " Tabs are 4 spaces
set backspace=2  " Backspace over everything in insert mode
set softtabstop=2
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab
set foldmethod=syntax
autocmd FileType go setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
autocmd FileType go map <F5> :!go build -o __temp__ % && ./__temp__ && rm __temp__<CR>
autocmd FileType ruby map <F5> :!ruby %<CR>
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python map <F5> :!python %<CR>
autocmd FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType php map <F5> :!php %<CR>

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set laststatus=2  " Always show status line.

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

autocmd BufEnter *
  \ if exists("b:rails_root") |
  \   let g:base_dir = b:rails_root |
  \ endif |


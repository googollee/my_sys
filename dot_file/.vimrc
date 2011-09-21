syntax enable
set cursorline
set ignorecase smartcase
set so=5

"保存文件时自动删除行尾空格或Tab
au BufWritePre * sil %s/\s\+$//e
"删除文件尾多余的空行
au BufWritePre * %s/^$\n\+\%$//ge
"显示tab和行尾空格
set list
set listchars=tab:>·,trail:·

if has('gui_running')
  set guifont=Menlo:h14
  colorscheme Tomorrow-Night
endif

filetype on  " Automatically detect file types.
filetype indent on
filetype plugin on
set nocompatible  " We don't want vi compatibility.

" Add recently accessed projects menu (project plugin)
set viminfo^=!

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
set nowrap  " Line wrapping off
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
" colorscheme vividchalk  " Uncomment this to set a default theme

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

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set laststatus=2  " Always show status line.

" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

autocmd BufEnter *
  \ if exists("b:rails_root") |
  \   let g:base_dir = b:rails_root |
  \ endif |

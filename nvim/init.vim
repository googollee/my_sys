call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/vim-plug'

Plug 'tpope/vim-sensible'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
Plug 'roxma/nvim-completion-manager'
Plug 'scrooloose/nerdcommenter'

Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'racer-rust/vim-racer', {'for': 'rust'}
Plug 'roxma/nvim-cm-racer', {'for': 'rust'}

Plug 'fatih/vim-go', {'for': 'go'}

Plug 'leafgarland/typescript-vim', {'for': 'ts'}
Plug 'Quramy/tsuquyomi', {'for': 'ts'}

Plug 'godlygeek/tabular', {'for': ['md', 'markdown']}
Plug 'plasticboy/vim-markdown', {'for': ['md', 'markdown']}

call plug#end()

" UI设置
syntax on                                               " 打开语法高亮
set number                                              " 显示行号
set showmatch                                           " 高亮括号配对
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1                     " 插入模式下光标变为竖线
color Tomorrow-Night
let g:airline_theme='lucius'
set cursorline

" 文件类型配置
filetype on                                             " 打开文件类型支持
filetype plugin on                                      " 打开文件类型插件支持
filetype indent on                                      " 打开文件类型缩进支持

" 文件编码
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set termencoding=utf-8

" 其他设置
set nocompatible                                        " 与vi不兼容
set backspace=indent,eol,start                          " 在insert模式下能用删除键进行删除
set smartcase                                           " 搜索时，智能大小写
set autoindent                                          " 自动缩进
set smartindent                                         " 智能缩进
set modeline                                            " 底部模式行
set comments=sl:/*,mb:\ *,elx:\ */                      " 智能注释
set incsearch                                           " incremental search
set lazyredraw                                          " Don't redraw while executing macros (good performance config)
set magic                                               " For regular expressions turn magic on
set autochdir                                           " 打开文件时，自动 cd 到文件所在目录
set smarttab
set expandtab
set shiftwidth=2
set softtabstop=2
set noswapfile

" Key binding
let mapleader = ","
nmap <silent> z <leader>
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <silent> <C-h> :wincmd h<cr>
nnoremap <silent> <C-j> :wincmd j<cr>
nnoremap <silent> <C-k> :wincmd k<cr>
nnoremap <silent> <C-l> :wincmd l<cr>
nnoremap <silent> <C-w> :tabnew<CR>
nnoremap <silent> <C-n> :tabprev<CR>
nnoremap <silent> <C-m> :tabnext<CR>
nnoremap <silent> <C-e> :call ToggleNERDTreeAndTagbar()<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Tagbar
let g:tagbar_left = 1
function! ToggleNERDTreeAndTagbar()
  let current_buf_name = bufname("")
  if stridx(current_buf_name, 'NERD_tree') >= 0
    NERDTreeClose
    TagbarOpen fj
  elseif stridx(current_buf_name, 'Tagbar') >= 0
    TagbarClose
    NERDTree
  else
    let open = 1
    if exists('t:NERDTreeBufName')
      if bufwinnr(t:NERDTreeBufName) != -1
        let open = 0
      endif
    endif
    if bufwinnr('__Tagbar__') != -1
      let open = 0
    endif

    if open
      NERDTree
    else
      NERDTreeClose
      TagbarClose
    endif
  endif
endfunction

" NerdCommenter
let g:NERDSpaceDelims=1

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2
autocmd BufWrite *.go :Autoformat
let g:syntastic_go_checkers = ['golint', 'gofmt', 'govet', 'go', 'errcheck']
let g:go_metalinter_enabled = []
let g:go_auto_sameids = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
let g:go_metalinter_autosave = 0
autocmd Filetype go nnoremap <leader>d :GoDef<CR>

" Typescript
autocmd BufNewFile,BufRead *.ts setlocal noexpandtab tabstop=2 shiftwidth=2
autocmd BufWrite *.ts :Autoformat
let g:syntastic_typescript_checkers = ['tsuquyomi']
if !exists("g:ycm_semantic_triggers")
	let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:tsuquyomi_completion_detail = 1
let g:tsuquyomi_shortest_import_path = 1
let g:tsuquyomi_disable_quickfix = 1

" Markdown
set conceallevel=1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

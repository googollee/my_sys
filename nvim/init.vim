let confdir = '~/.vim'
if has('nvim')
  let confdir = '~/.config/nvim'
endif

" Specify a directory for plugins
call plug#begin(confdir.'/plugged')
" Make sure you use single quotes

Plug 'chriskempson/vim-tomorrow-theme'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive' " git
Plug 'junegunn/gv.vim' " git log
Plug 'airblade/vim-gitgutter' " git diff
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
if !has('nvim')
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'godlygeek/tabular', {'for': ['md', 'markdown']}
Plug 'plasticboy/vim-markdown', {'for': ['md', 'markdown']}

Plug 'ledger/vim-ledger', {'for': 'ledger'}

Plug 'prabirshrestha/async.vim', {'for': ['go', 'typescript']}
Plug 'prabirshrestha/vim-lsp', {'for': ['go', 'typescript']}
Plug 'ncm2/ncm2-vim-lsp', {'for': ['go', 'typescript']}

Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'ncm2/ncm2-go', {'for': 'go'}

Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'ryanolsonx/vim-lsp-typescript', {'for': 'typescript'}

" Initialize plugin system
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
set smarttab
set expandtab
set shiftwidth=2
set softtabstop=2
set noswapfile

" Key binding
let mapleader = ","
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
nnoremap <silent> ,m :call NERDComment(0,"toggle")<CR>
vnoremap <silent> ,m :call NERDComment(0,"toggle")<CR>
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

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol='x'
let g:syntastic_warning_symbol='!'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NCM2
let g:python3_host_prog="python3"
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Go
" :GoInstallBinaries
let g:syntastic_go_checkers = ['go']
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2
autocmd Filetype go nmap <leader>b <Plug>(go-build)
autocmd Filetype go nmap <leader>d <Plug>(go-def-tab)
autocmd Filetype go nmap <leader>r <Plug>(go-run-split)
autocmd Filetype go nmap <leader>t <Plug>(go-coverage-toggle)
autocmd Filetype go nnoremap <c-n> :lnext<CR>
autocmd Filetype go nnoremap <c-m> :lprevious<CR>
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 0
let g:go_mod_fmt_autosave = 1

" Typescript
let g:syntastic_typescript_checkers = ['tslint']
autocmd BufNewFile,BufRead *.ts setlocal expandtab tabstop=2 shiftwidth=2
if executable('typescript-language-server')
  " npm i -g typescript-language-server
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
      \ 'whitelist': ['typescript'],
      \ })
  autocmd FileType typescript setlocal omnifunc=lsp#complete
  autocmd Filetype typescript nnoremap <c-,> :lnext<CR>
  autocmd Filetype typescript nnoremap <c-.> :lprevious<CR>
  autocmd FileType typescript nnoremap <buffer><silent> <c-]> :LspDefinition<cr>
  autocmd Filetype typescript nnoremap <buffer><silent> <c-\> :LspHover<CR>
endif

" Markdown
set conceallevel=1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_folding_level = 6

" Ledger
autocmd BufNewFile,BufRead *.ledger set filetype=ledger
let g:ledger_maxwidth = 80
autocmd FileType ledger noremap { ?^\d<CR>
autocmd FileType ledger noremap } /^\d<CR>
autocmd FileType ledger inoremap <silent> <Tab> <C-r>=ledger#autocomplete_and_align()<CR>
autocmd FileType ledger vnoremap <silent> <Tab> :LedgerAlign<CR>

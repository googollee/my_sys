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
Plug 'Valloric/YouCompleteMe'

Plug 'fatih/vim-go', {'for': 'go'}

Plug 'leafgarland/typescript-vim', {'for': 'ts'}
Plug 'Quramy/tsuquyomi', {'for': 'ts'}

Plug 'godlygeek/tabular', {'for': ['md', 'markdown']}
Plug 'plasticboy/vim-markdown', {'for': ['md', 'markdown']}

call plug#end()

filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Tagbar
let g:tagbar_left = 1
function! ToggleNERDTreeAndTagbar()
	" Detect which plugins are open
	if exists('t:NERDTreeBufName')
		let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
	else
		let nerdtree_open = 0
	endif
	let tagbar_open = bufwinnr('__Tagbar__') != -1

	" Perform the appropriate action
	if nerdtree_open
		NERDTreeClose
		TagbarOpen fj
	elseif tagbar_open
		TagbarClose
	else
		NERDTree
	endif
endfunction

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

" General
color Tomorrow-Night
let g:airline_theme='lucius'
syntax on
set number
set cursorline
set foldlevelstart=20
autocmd BufNewFile,BufRead * setlocal noexpandtab tabstop=4 shiftwidth=4

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
autocmd BufNewFile,BufRead *.ts setlocal noexpandtab tabstop=4 shiftwidth=4
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

require 'plugins'

local noremap = require'shim'.noremap
local map = require'shim'.map
local augroup = require'shim'.augroup
local autocmd = require'shim'.autocmd
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- UI
opt.number = true
opt.showmatch = true
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true
opt.list = true
opt.shiftround = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.backspace = 'indent,eol,start'
opt.autoindent = true
opt.smartindent = true
opt.modeline = true
opt.incsearch = true
opt.lazyredraw = true
opt.magic = true
opt.smarttab = true

-- Color scheme
cmd 'syntax on'
cmd 'color Tomorrow-Night'
g.airline_theme = 'lucius'

-- Filetype
cmd 'filetype on'
cmd 'filetype plugin on'
cmd 'filetype indent on'

-- File codec
opt.enc = 'utf-8'
opt.fenc = 'utf-8'

-- Key binding
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
vim.g.mapleader = ','
noremap('n', '<C-h>', ':wincmd h<CR>')
noremap('n', '<C-j>', ':wincmd j<CR>')
noremap('n', '<C-k>', ':wincmd k<CR>')
noremap('n', '<C-l>', ':wincmd l<CR>')
noremap('n', '<C-w>', ':tabnew<CR>')
noremap('n', '<C-n>', ':tabprev<CR>')
noremap('n', '<C-m>', ':tabnext<CR>')
noremap('n', '<C-[>', ':cprevious<CR>')
noremap('n', '<C-]>', ':cnext<CR>')
noremap('n', '<leader>,', ':call NERDComment(0, "toggle")<CR>')
noremap('v', '<leader>,', ':call NERDComment(0, "toggle")<CR>')

-- Using lua functions
noremap('n', '<leader>ff', ':Telescope find_files<CR>')
noremap('n', '<leader>fg', ':Telescope live_grep<CR>')
noremap('n', '<leader>fb', ':Telescope buffers<CR>')
noremap('n', '<leader>fh', ':Telescope help_tags<CR>')

-- NerdCommenter
g.NERDSpaceDelims = 1

-- Neoformat
augroup('fmt', {
  autocmd('BufWritePre', '*.go', 'undojoin | Neoformat'),
})

-- Markdown
opt.conceallevel = 1
g.vim_markdown_frontmatter = 1
g.vim_markdown_toml_frontmatter = 1
g.vim_markdown_json_frontmatter = 1
g.vim_markdown_new_list_item_indent = 2
g.vim_markdown_folding_level = 6

function LspBinaryInstall()
end

-- Go
augroup('fmt', {
  autocmd('BufNewFile,BufRead', '*.go', 'setlocal noexpandtab tabstop=2 shiftwidth=2'),
  autocmd('BufWritePre', '*.go', 'undojoin | Neoformat'),
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"go", "gomod", "lua", "bash"},
  highlight = {
    enable = true,
  },
}

require 'lsp-settings'
require 'nvim-compe'

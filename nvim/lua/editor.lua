local feature = require('fur.feature')

-- NerdCommenter

local commenter = feature:new('commenter')
commenter.plugins = {
  'scrooloose/nerdcommenter',
}
commenter.setup = function()
  vim.g.NERDSpaceDelims = 1
end
commenter.mappings = {
  {'n', '<leader>,', ':call nerdcommenter#Comment(0, "toggle")<CR>'},
  {'v', '<leader>,', ':call nerdcommenter#Comment(0, "toggle")<CR>'},
}

-- UI

local ui = feature:new('ui')
ui.plugins = {
  'chriskempson/vim-tomorrow-theme',
  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',
}
ui.setup = function()
  vim.cmd 'color Tomorrow-Night'
  vim.g.airline_theme = 'lucius'
end

-- TreeSitter

local treesitter = feature:new('treesitter')
treesitter.plugins = {
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
}
treesitter.setup = function()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    indent = {
      enable = true
    },
  }
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
end

-- Editor

local editor = feature:new('editor')

editor.source = 'lua/editor.lua'

editor.plugins = {
  'tpope/vim-sensible',
  'jiangmiao/auto-pairs',
}

editor.setup = function()
  local cmd = vim.cmd
  local g = vim.g
  local opt = vim.opt

  opt.foldenable = false
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
  opt.enc = 'utf-8'
  opt.fenc = 'utf-8'
  opt.conceallevel = 1

  -- Color scheme
  cmd 'syntax on'

  -- Filetype
  cmd 'filetype on'
  cmd 'filetype plugin on'
  cmd 'filetype indent on'

  g.mapleader = ','
end

editor.mappings = {
  {'n', '<C-h>', ':wincmd h<CR>'},
  {'n', '<C-j>', ':wincmd j<CR>'},
  {'n', '<C-k>', ':wincmd k<CR>'},
  {'n', '<C-l>', ':wincmd l<CR>'},
  {'n', '<C-w>', ':tabnew<CR>'},
  {'n', '<C-n>', ':tabprev<CR>'},
  {'n', '<C-m>', ':tabnext<CR>'},
  {'n', '<C-[>', ':cprevious<CR>'},
  {'n', '<C-]>', ':cnext<CR>'},
}

editor.children = { commenter, ui, treesitter }

return editor

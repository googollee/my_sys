return function(packer)
  packer 'tpope/vim-sensible'
  packer 'jiangmiao/auto-pairs'

  packer {
    'vim-airline/vim-airline',
    requires = {
      'vim-airline/vim-airline-themes',
    },
    config = function() 
      vim.g.airline_theme = 'lucius'
    end,
  }

  packer {
    'chriskempson/vim-tomorrow-theme',
    config = function()
      vim.cmd 'set termguicolors'
      vim.cmd 'color Tomorrow-Night'
      vim.cmd 'hi LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f'
    end,
  }

  packer {
    'scrooloose/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1

      local util = require('util')
      util.noremap('n', '<leader>,', ':call nerdcommenter#Comment(0, "toggle")<CR>')
      util.noremap('v', '<leader>,', ':call nerdcommenter#Comment(0, "toggle")<CR>')
    end,
  }

  vim.opt.foldenable = false
  vim.opt.number = true
  vim.opt.showmatch = true
  vim.opt.cursorline = true
  vim.opt.expandtab = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.list = true
  vim.opt.shiftround = true
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  vim.opt.backspace = 'indent,eol,start'
  vim.opt.autoindent = true
  vim.opt.smartindent = true
  vim.opt.modeline = true
  vim.opt.incsearch = true
  vim.opt.lazyredraw = true
  vim.opt.magic = true
  vim.opt.smarttab = true
  vim.opt.enc = 'utf-8'
  vim.opt.fenc = 'utf-8'
  vim.opt.conceallevel = 1

  -- Color scheme
  vim.cmd 'syntax on'

  -- Filetype
  vim.cmd 'filetype on'
  vim.cmd 'filetype plugin on'
  vim.cmd 'filetype indent on'

  vim.g.mapleader = ','

  local util = require('util')
  util.noremap('n', '<C-h>', ':wincmd h<CR>')
  util.noremap('n', '<C-j>', ':wincmd j<CR>')
  util.noremap('n', '<C-k>', ':wincmd k<CR>')
  util.noremap('n', '<C-l>', ':wincmd l<CR>')
  util.noremap('n', '<C-w>', ':tabnew<CR>')
  util.noremap('n', '<C-n>', ':tabprev<CR>')
  util.noremap('n', '<C-m>', ':tabnext<CR>')
  util.noremap('n', '<C-[>', ':cprevious<CR>')
  util.noremap('n', '<C-]>', ':cnext<CR>')
end

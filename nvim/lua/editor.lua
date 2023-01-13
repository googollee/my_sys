return function(packer)
  util = require('util')

  packer 'tpope/vim-sensible'

  packer {
    'Raimondi/delimitMate',
    config = function()
      vim.g.delimitMate_expand_cr = 1
      vim.g.delimitMate_expand_space = 1
      vim.g.delimitMate_jump_expansion = 1
    end,
  }

  packer {
    'ggandor/leap.nvim',
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
      leap.opts.safe_labels = {}

      -- Bidirectional search
      util.noremap('n', 's', ':lua require("leap").leap { target_windows = { vim.fn.win_getid() } }<CR>')
      util.noremap('v', 's', ':lua require("leap").leap { target_windows = { vim.fn.win_getid() } }<CR>')
    end
  }

  packer {
    'nathanaelkane/vim-indent-guides',
    config = function()
      vim.cmd([[
        let g:indent_guides_enable_on_vim_startup = 1
        let g:indent_guides_auto_colors = 0
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235 ctermfg=darkgray
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236 ctermfg=darkgray
      ]])
    end
  }

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
      -- vim.cmd 'set termguicolors'
      vim.cmd 'color Tomorrow-Night'
      vim.cmd 'hi LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f'
    end,
  }

  packer {
    'scrooloose/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1

      util.noremap('n', '<leader>,', ':call nerdcommenter#Comment(0, "toggle")<CR>')
      util.noremap('v', '<leader>,', ':call nerdcommenter#Comment(0, "toggle")<CR>')
    end,
  }

  packer {
    'folke/trouble.nvim',
    config = function()
      require("trouble").setup {
        icons = false,
        fold_open = "v",
        fold_closed = ">",
        indent_lines = true,
        signs = {
          error = "x",
          warning = "!",
          hint = "?",
          information = "i",
          other = ">",
        },
      }

      util.noremap("n", "<leader>x", "<cmd>TroubleToggle<cr>")
    end
  }

  vim.opt.foldenable = false
  vim.opt.number = true
  vim.opt.showmatch = true
  vim.opt.cursorline = true
  vim.opt.expandtab = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.list = true
  vim.opt.listchars:append('eol:↴')
  vim.opt.listchars:append('tab:¦ ')
  vim.opt.listchars:append('trail:·')
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
  vim.opt.updatetime = 1000

  local util = require('util')
  local augroup = util.augroup
  local autocmd = util.autocmd

  augroup('lsp_document_highlight', {
    autocmd('CursorHold', '<buffer>', 'lua vim.diagnostic.open_float()'),
  })

  -- Color scheme
  vim.cmd 'syntax on'

  -- Filetype
  vim.cmd 'filetype on'
  vim.cmd 'filetype plugin on'
  vim.cmd 'filetype indent on'

  vim.g.mapleader = ','

  util.noremap('n', '<C-h>', ':wincmd h<CR>')
  util.noremap('n', '<C-j>', ':wincmd j<CR>')
  util.noremap('n', '<C-k>', ':wincmd k<CR>')
  util.noremap('n', '<C-l>', ':wincmd l<CR>')
  util.noremap('n', '<C-w>', ':tabnew<CR>')
  util.noremap('n', '<C-u>', ':tabprev<CR>')
  util.noremap('n', '<C-i>', ':tabnext<CR>')
  util.noremap('n', '<TAB>', ':tabnext<CR>')
  util.noremap('n', '<C-[>', ':cprevious<CR>')
  util.noremap('n', '<C-]>', ':cnext<CR>')
end

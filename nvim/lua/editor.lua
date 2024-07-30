return function(use)
  util = require('util')

  use 'tpope/vim-sensible'

  use {
    'Raimondi/delimitMate',
    config = function()
      vim.g.delimitMate_expand_cr = 1
      vim.g.delimitMate_expand_space = 1
      vim.g.delimitMate_jump_expansion = 1
    end,
  }

  use {
    'ggandor/leap.nvim',
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
      leap.opts.safe_labels = {}

      -- Bidirectional search
      util.noremap('n', 's', ':lua require("leap").leap { target_windows = { vim.fn.win_getid() } }<CR>')
      util.noremap('v', 's', ':lua require("leap").leap { target_windows = { vim.fn.win_getid() } }<CR>')
      vim.keymap.del({'x', 'o'}, 'x')
      vim.keymap.del({'x', 'o'}, 'X')
    end
  }

  use {
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

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
      }
    end,
  }

  use {
    'chriskempson/vim-tomorrow-theme',
    config = function()
      -- vim.cmd 'set termguicolors'
      vim.cmd 'color Tomorrow-Night'
      vim.cmd 'hi LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f'
    end,
  }

  use {
    'scrooloose/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1

      util.noremap('n', '<leader>,', ':call nerdcommenter#Comment(0, "toggle")<CR>')
      util.noremap('v', '<leader>,', ':call nerdcommenter#Comment(0, "toggle")<CR>')
    end,
  }

  use {
    'folke/trouble.nvim',
    config = function()
      require("trouble").setup({
        position = "bottom",
        icons = true,
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "v",
        fold_closed = ">",
        indent_lines = true,
        group = true,
        padding = true,
        action_keys = {
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" }, -- open buffer in new split
          open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
          open_tab = { "<c-t>" }, -- open buffer in new tab
          jump_close = { "o" }, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" }, -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k", -- preview item
          next = "j", -- next item
        },
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
        signs = {
          error = "x",
          warning = "!",
          hint = "?",
          information = "i",
          other = "-",
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
      })

      util.noremap("n", "<Leader>xx", "<Cmd>TroubleToggle<CR>")
      util.noremap("n", "<Leader>xw", "<Cmd>Trouble workspace_diagnostics<CR>")
      util.noremap("n", "<Leader>xd", "<Cmd>Trouble document_diagnostics<CR>")
      util.noremap("n", "<Leader>xl", "<Cmd>Trouble loclist<CR>")
      util.noremap("n", "<Leader>xq", "<Cmd>Trouble quickfix<CR>")
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
  vim.opt.mouse = ''

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

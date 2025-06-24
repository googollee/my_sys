return function(add, now, later)
  require('mini.basics').setup()

  add { source = 'chriskempson/vim-tomorrow-theme' }
  now(function()
    -- vim.cmd 'set termguicolors'
    vim.cmd 'color Tomorrow-Night'
    vim.cmd 'hi LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f'
  end)

  add { source = 'jiangmiao/auto-pairs' }

  local notify = require('mini.notify')
  notify.setup()
  vim.notify = notify.make_notify({
    ERROR = {duration = 5000},
    WARN  = {duration = 4000},
    INFO  = {duration = 3000},
  })

  require('mini.jump2d').setup()

  require('mini.comment').setup({
    mappings = {
      comment = '<leader>,',
      comment_line = '<leader>,',
      comment_visual = '<leader>,',
      textobject = '<leader>,',
    },
  })

  require('mini.icons').setup({ style = 'ascii' })

  require('mini.indentscope').setup()

  require('mini.git').setup()

  require('mini.diff').setup({
    view = {
      style = vim.opt.number and 'number' or 'sign',
    },
  })

  add { source = 'crispgm/nvim-tabline' }
  require('tabline').setup({})
  vim.opt.showtabline = 2
  vim.api.nvim_set_hl(0, 'TabLineSel', {ctermfg = 'white'})

  require('mini.pick').setup()
  vim.keymap.set('n', '<C-p>', ':Pick files<CR>')
  vim.keymap.set('n', '<C-f>', ':Pick grep_live<CR>')

  vim.opt.completeopt = "menuone,noselect,fuzzy"
  vim.opt.ignorecase = true
  require('mini.completion').setup()
  local map_multistep = require('mini.keymap').map_multistep
  map_multistep('i', '<Tab>',   { 'pmenu_next' })
  map_multistep('i', '<S-Tab>', { 'pmenu_prev' })

  require('mini.map').setup()

  vim.opt.wrap = true
  vim.opt.foldenable = false
  vim.opt.number = true
  vim.opt.showmatch = true
  vim.opt.cursorline = true
  vim.opt.expandtab = true vim.opt.ignorecase = true
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

  local lsp_hl = vim.api.nvim_create_augroup("lsp_document_highlight", {clear = true})
  vim.api.nvim_create_autocmd('CursorHold', {
      command = 'lua vim.diagnostic.open_float()',
      group = lsp_hl,
  })

  -- Color scheme
  vim.cmd 'syntax on'

  -- Filetype
  vim.cmd 'filetype on'
  vim.cmd 'filetype plugin on'
  vim.cmd 'filetype indent on'

  vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
  vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
  vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
  vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
  vim.keymap.set('n', '<C-w>', ':tabnew<CR>')
  vim.keymap.set('n', '<C-u>', ':tabprev<CR>')
  vim.keymap.set('n', '<C-i>', ':tabnext<CR>')
end

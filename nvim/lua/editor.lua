return function(add, now, later)
  util = require('util')

  require('mini.basics').setup()

  add { source = 'chriskempson/vim-tomorrow-theme' }
  now(function()
    -- vim.cmd 'set termguicolors'
    vim.cmd 'color Tomorrow-Night'
    vim.cmd 'hi LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f'
  end)

  local notify = require('mini.notify')
  notify.setup()
  vim.notify = notify.make_notify({
    ERROR = {duration = 5000},
    WARN  = {duration = 4000},
    INFO  = {duration = 3000},
  })

  require('mini.pairs').setup({
    mappings = {
      ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].', register = { cr = false } },
      ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].', register = { cr = false } },
      ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].', register = { cr = false } },

      [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].', register = { cr = false } },
      [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].', register = { cr = false } },
      ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].', register = { cr = false } },

      ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
      ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
      ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
    },
  })

  require('mini.jump2d').setup()

  require('mini.comment').setup()

  require('mini.icons').setup({ style = 'ascii' })

  require('mini.indentscope').setup()

  require('mini.git').setup()

  require('mini.diff').setup({
    view = {
      style = vim.opt.number and 'number' or 'sign',
    },
  })

  require('mini.statusline').setup()
  require('mini.tabline').setup({
    format = function(buf_id, label)
      local suffix = vim.bo[buf_id].modified and '+' or ''
      if buf_id == vim.api.nvim_get_current_buf() then
        return string.format('*%s%s*', label, suffix)
      end
      return string.format(' %s%s ', label, suffix)
    end,
  })

  require('mini.pick').setup()
  util.noremap('n', '<C-p>', ':Pick files<CR>')
  util.noremap('n', '<C-f>', ':Pick grep_live<CR>')

  vim.opt.completeopt = "menuone,noselect,fuzzy"
  vim.opt.ignorecase = true
  require('mini.completion').setup()
  local map_multistep = require('mini.keymap').map_multistep
  map_multistep('i', '<Tab>',   { 'pmenu_next' })
  map_multistep('i', '<S-Tab>', { 'pmenu_prev' })

  require('mini.map').setup()

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
  util.noremap('n', '<C-[>', ':cprevious<CR>')
  util.noremap('n', '<C-]>', ':cnext<CR>')
end

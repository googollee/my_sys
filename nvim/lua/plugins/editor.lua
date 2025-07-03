return {
  {
    'chriskempson/vim-tomorrow-theme',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd 'set termguicolors'
      vim.cmd([[color Tomorrow-Night]])
      vim.cmd([[hi LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f]])
    end,
  },

  { 
    'hedyhli/outline.nvim',
    opts = {
      symbols = {
        icon_fetcher = function(k, buf)
          if k == 'String' then
            return ""
          end
          return false
        end,
        icon_source = 'lspkind',
      }
    },
    lazy = false,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      { '<C-e>', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
  },

  { 'jiangmiao/auto-pairs' },

  { 'crispgm/nvim-tabline' },

  { 
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
    end,
  },

  {
    'onsails/lspkind.nvim',
    opts = {
      mode = 'text',
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      {'<C-p>', '<cmd>Telescope find_files<cr>'},
      {'<C-f>', '<cmd>Telescope live_grep<cr>'},
    },
  },

  {
    'echasnovski/mini.nvim', 
    version = '*',
    config = function()
      require('mini.jump2d').setup({})
      require('mini.comment').setup({
        mappings = {
          comment = '<leader>,',
          comment_line = '<leader>,',
          comment_visual = '<leader>,',
          textobject = '<leader>,',
        },
      })
      require('mini.indentscope').setup()
      require('mini.git').setup()
      require('mini.diff').setup({
        view = {
          style = vim.opt.number and 'number' or 'sign',
        },
      })
      require('mini.map').setup()
    end,
  },
}

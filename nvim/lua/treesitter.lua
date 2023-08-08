return function(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = false,
        },
        indent = {
          enable = true
        },
      }
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    end
  }
end

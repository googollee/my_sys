return function(use)
  use 'tpope/vim-fugitive' -- git

  use 'junegunn/gv.vim' -- git log

  use { -- git diff
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
      })
    end
  }
end

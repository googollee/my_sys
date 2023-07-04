return function(packer)
  packer 'tpope/vim-fugitive' -- git
  packer 'junegunn/gv.vim' -- git log
  packer { -- git diff
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
      })
    end
  }
end

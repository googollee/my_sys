return function(packer)
  packer {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    config = function()
      vim.g.NERDSpaceDelims = 1

      local util = require('util')
      util.noremap('n', '<C-p>', ':Telescope find_files<CR>')
      util.noremap('n', '<leader>fg', ':Telescope live_grep<CR>')
      util.noremap('n', '<leader>fb', ':Telescope buffers<CR>')
      util.noremap('n', '<leader>fh', ':Telescope help_tags<CR>')
    end,
  }
end

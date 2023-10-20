return function(use)
  use {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    config = function()
      vim.g.NERDSpaceDelims = 1

      local util = require('util')
      util.noremap('n', '<C-p>', ':Telescope find_files<CR>')
      util.noremap('n', '<C-f>', ':Telescope lsp_document_symbols<CR>')↴
      util.noremap('n', '<leader>fg', ':Telescope live_grep<CR>')
      util.noremap('n', '<leader>fb', ':Telescope buffers<CR>')
      util.noremap('n', '<leader>fh', ':Telescope help_tags<CR>')

      vim.api.nvim_create_user_command('CfgReload', function()
        require('plenary.reload').reload_module('.')
      end, {})
    end,
  }
end

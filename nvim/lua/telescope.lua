local feature = require('fur.feature')

local f = feature:new('telescope')
f.source = 'lua/telescope.lua'
f.plugins = {
  {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
  },
}
f.setup = function()
  vim.g.NERDSpaceDelims = 1
end
f.mappings = {
  {'n', '<C-p>', ':Telescope find_files<CR>'},
  {'n', '<leader>ff', ':Telescope find_files<CR>'},
  {'n', '<leader>fg', ':Telescope live_grep<CR>'},
  {'n', '<leader>fb', ':Telescope buffers<CR>'},
  {'n', '<leader>fh', ':Telescope help_tags<CR>'},
}

return f

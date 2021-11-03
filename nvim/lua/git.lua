local feature = require('fur.feature')

local f = feature:new('git')
f.source = 'lua/git.lua'
f.plugins = {
  'tpope/vim-fugitive', -- git
  'junegunn/gv.vim', -- git log
  'airblade/vim-gitgutter', -- git diff
}

return f

